param(
    [int]$HubPort = 5600,
    [switch]$SkipApps,
    [switch]$ForceRestart
)

$ErrorActionPreference = "Stop"

$Root = $PSScriptRoot
$HubDir = Join-Path $Root "hub"
$NewAoproDir = "C:\Users\mscaff\Documents\newaopro"
$RuntimeDir = Join-Path $Root ".hub-runtime"
$HubPidFile = Join-Path $RuntimeDir "hub_server.pid"
$ProjetoPidFile = Join-Path $RuntimeDir "projeto_completo.pid"
$NewAoproFrontendPidFile = Join-Path $RuntimeDir "newaopro_frontend.pid"
$NewAoproBackendPidFile = Join-Path $RuntimeDir "newaopro_backend.pid"
$NewAoproFrontendPort = 5000
$NewAoproBackendPort = 5001

if (-not (Test-Path $HubDir)) {
    throw "Diretorio do portal nao encontrado: $HubDir"
}

New-Item -ItemType Directory -Force -Path $RuntimeDir | Out-Null

function Get-ListeningPids {
    param([int]$Port)
    $hits = netstat -ano | Select-String "LISTENING" | Where-Object { $_.ToString() -match (":" + $Port + "\s") }
    $pids = @()
    foreach ($line in $hits) {
        $text = $line.ToString()
        if ($text -match "\s+(\d+)\s*$") {
            $pids += [int]$matches[1]
        }
    }
    return @($pids | Select-Object -Unique)
}

function Test-PortListening {
    param([int]$Port)
    return ((Get-ListeningPids -Port $Port).Count -gt 0)
}

function Test-Url200 {
    param(
        [string]$Url,
        [int]$TimeoutSec = 4
    )
    try {
        $status = (Invoke-WebRequest -Uri $Url -UseBasicParsing -TimeoutSec $TimeoutSec).StatusCode
        return ($status -ge 200 -and $status -lt 300)
    }
    catch {
        return $false
    }
}

function Test-SdrsOnline {
    $be = Test-Url200 -Url "http://127.0.0.1:8010/api/health" -TimeoutSec 4
    $fe = Test-Url200 -Url "http://127.0.0.1:5500/index.html" -TimeoutSec 4
    return ($be -and $fe)
}

function Test-TesteInterfaceOnline {
    return (Test-Url200 -Url "http://127.0.0.1:8000/health" -TimeoutSec 4)
}

function Read-PidFile {
    param([string]$PidFile)
    if (-not (Test-Path $PidFile)) {
        return $null
    }
    $raw = (Get-Content -Path $PidFile -Raw).Trim()
    if ($raw -match "^\d+$") {
        return [int]$raw
    }
    return $null
}

function Stop-ProcessSafe {
    param([int]$ProcessId)
    $proc = Get-Process -Id $ProcessId -ErrorAction SilentlyContinue
    if ($proc) {
        try {
            Stop-Process -Id $ProcessId -Force
        }
        catch {
            Write-Host "Aviso: falha ao parar PID $ProcessId ($($_.Exception.Message))."
        }
    }
}

function Resolve-PythonGlobal {
    $known312 = Join-Path $env:LOCALAPPDATA "Programs\Python\Python312\python.exe"
    if (Test-Path $known312) {
        return $known312
    }

    $pythonCmd = Get-Command python -ErrorAction SilentlyContinue
    if ($pythonCmd -and $pythonCmd.Source -and ($pythonCmd.Source -notmatch "WindowsApps")) {
        return $pythonCmd.Source
    }

    throw "Python nao encontrado no PATH."
}

function Resolve-NewAoproBackendPython {
    $venvPy = Join-Path $NewAoproDir "backend\.venv\Scripts\python.exe"
    if (Test-Path $venvPy) {
        return $venvPy
    }
    return (Resolve-PythonGlobal)
}

function Ensure-HubServer {
    param([int]$Port)

    $knownPid = Read-PidFile -PidFile $HubPidFile
    $portPids = @(Get-ListeningPids -Port $Port)
    if ($portPids.Count -gt 0) {
        $managed = $knownPid -and ($portPids -contains $knownPid)
        if ($managed -and (Test-Url200 -Url "http://127.0.0.1:$Port/index.html")) {
            Write-Host "Portal hub ja ativo em http://127.0.0.1:$Port/index.html"
            return
        }
        throw "Porta $Port ja esta em uso por processo externo (PID: $($portPids -join ', '))."
    }

    $pythonExe = Resolve-PythonGlobal
    $outLog = Join-Path $RuntimeDir "hub_$Port.out.log"
    $errLog = Join-Path $RuntimeDir "hub_$Port.err.log"
    foreach ($f in @($outLog, $errLog)) {
        if (Test-Path $f) {
            Remove-Item $f -Force -ErrorAction SilentlyContinue
        }
    }

    $proc = Start-Process `
        -FilePath $pythonExe `
        -ArgumentList @("-m", "http.server", "$Port", "--bind", "127.0.0.1") `
        -WorkingDirectory $HubDir `
        -WindowStyle Hidden `
        -RedirectStandardOutput $outLog `
        -RedirectStandardError $errLog `
        -PassThru

    $proc.Id | Set-Content -Path $HubPidFile -Encoding ascii

    $ok = $false
    for ($i = 0; $i -lt 10; $i++) {
        if (Test-Url200 -Url "http://127.0.0.1:$Port/index.html") {
            $ok = $true
            break
        }
        Start-Sleep -Milliseconds 500
    }
    if (-not $ok) {
        Stop-ProcessSafe -ProcessId $proc.Id
        throw "Portal do hub nao respondeu em http://127.0.0.1:$Port/index.html"
    }

    Write-Host "Portal hub iniciado em http://127.0.0.1:$Port/index.html"
}

function Ensure-ProjetoCompleto {
    $projetoDir = $NewAoproDir
    $frontendDir = Join-Path $projetoDir "frontend"
    $backendDir = Join-Path $projetoDir "backend"
    $frontendPort = $NewAoproFrontendPort
    $backendPort = $NewAoproBackendPort

    if (-not (Test-Path $projetoDir)) {
        throw "Diretorio do novo projeto nao encontrado: $projetoDir"
    }
    if (-not (Test-Path $frontendDir)) {
        throw "Diretorio frontend do newaopro nao encontrado: $frontendDir"
    }
    if (-not (Test-Path $backendDir)) {
        throw "Diretorio backend do newaopro nao encontrado: $backendDir"
    }

    $frontendPids = @(Get-ListeningPids -Port $frontendPort)
    $backendPids = @(Get-ListeningPids -Port $backendPort)

    if ($frontendPids.Count -gt 0 -and $backendPids.Count -gt 0) {
        $frontendOk = Test-Url200 -Url "http://127.0.0.1:$frontendPort" -TimeoutSec 4
        $backendOk = Test-Url200 -Url "http://127.0.0.1:$backendPort/health" -TimeoutSec 4
        if ($frontendOk -and $backendOk) {
            Write-Host "newaopro ja ativo em http://127.0.0.1:$frontendPort (backend $backendPort)."
            return
        }
    }

    if ($frontendPids.Count -gt 0) {
        throw "Porta $frontendPort ja esta em uso por processo externo (PID: $($frontendPids -join ', '))."
    }
    if ($backendPids.Count -gt 0) {
        throw "Porta $backendPort ja esta em uso por processo externo (PID: $($backendPids -join ', '))."
    }

    $pythonExe = Resolve-NewAoproBackendPython
    $npmCmd = Get-Command npm.cmd -ErrorAction SilentlyContinue
    if (-not $npmCmd) {
        $npmCmd = Get-Command npm -ErrorAction SilentlyContinue
    }
    if (-not $npmCmd) {
        throw "npm nao encontrado no PATH para iniciar o frontend do newaopro."
    }

    $env:DATABASE_URL = "sqlite:///oceanstor_local.db"
    $env:CORS_ORIGINS = "http://127.0.0.1:$frontendPort,http://localhost:$frontendPort"
    $env:VITE_API_BASE_URL = "http://127.0.0.1:$backendPort/api/v1"

    $dbInitCode = @'
import app.models
from app.db.session import Base, SessionLocal, engine
from app.core.auth import ensure_initial_admin

Base.metadata.create_all(bind=engine)
db = SessionLocal()
try:
    ensure_initial_admin(db)
finally:
    db.close()
print("db ready")
'@

    Push-Location $backendDir
    try {
        & $pythonExe -c $dbInitCode | Out-Host
    }
    finally {
        Pop-Location
    }

    $backendOutLog = Join-Path $RuntimeDir "newaopro_backend_$backendPort.out.log"
    $backendErrLog = Join-Path $RuntimeDir "newaopro_backend_$backendPort.err.log"
    $frontendOutLog = Join-Path $RuntimeDir "newaopro_frontend_$frontendPort.out.log"
    $frontendErrLog = Join-Path $RuntimeDir "newaopro_frontend_$frontendPort.err.log"
    foreach ($f in @($backendOutLog, $backendErrLog, $frontendOutLog, $frontendErrLog)) {
        if (Test-Path $f) {
            Remove-Item $f -Force -ErrorAction SilentlyContinue
        }
    }

    $backendProc = Start-Process `
        -FilePath $pythonExe `
        -ArgumentList @("-m", "uvicorn", "app.main:app", "--host", "127.0.0.1", "--port", "$backendPort") `
        -WorkingDirectory $backendDir `
        -WindowStyle Hidden `
        -RedirectStandardOutput $backendOutLog `
        -RedirectStandardError $backendErrLog `
        -PassThru

    $frontendProc = Start-Process `
        -FilePath $npmCmd.Source `
        -ArgumentList @("run", "dev", "--", "--host", "127.0.0.1", "--port", "$frontendPort") `
        -WorkingDirectory $frontendDir `
        -WindowStyle Hidden `
        -RedirectStandardOutput $frontendOutLog `
        -RedirectStandardError $frontendErrLog `
        -PassThru

    $backendProc.Id | Set-Content -Path $NewAoproBackendPidFile -Encoding ascii
    $frontendProc.Id | Set-Content -Path $NewAoproFrontendPidFile -Encoding ascii
    @($backendProc.Id, $frontendProc.Id) | Set-Content -Path $ProjetoPidFile -Encoding ascii

    $ready = $false
    for ($i = 0; $i -lt 90; $i++) {
        $frontendOk = Test-Url200 -Url "http://127.0.0.1:$frontendPort" -TimeoutSec 3
        $backendOk = Test-Url200 -Url "http://127.0.0.1:$backendPort/health" -TimeoutSec 3
        if ($frontendOk -and $backendOk) {
            $ready = $true
            break
        }
        Start-Sleep -Seconds 2
    }
    if (-not $ready) {
        Stop-ProcessSafe -ProcessId $backendProc.Id
        Stop-ProcessSafe -ProcessId $frontendProc.Id
        throw "newaopro nao respondeu em http://127.0.0.1:$frontendPort e http://127.0.0.1:$backendPort/health. Logs: $backendErrLog / $frontendErrLog"
    }

    Write-Host "newaopro iniciado em http://127.0.0.1:$frontendPort (backend http://127.0.0.1:$backendPort)"
}

function Start-TesteInterface {
    if (Test-TesteInterfaceOnline) {
        Write-Host "teste de interface ja esta online. Seguindo."
        return
    }

    $script = Join-Path $Root "teste de interface\start.ps1"
    if (-not (Test-Path $script)) {
        throw "Script nao encontrado: $script"
    }
    if ($env:DATABASE_URL -eq "sqlite:///oceanstor_local.db") {
        Remove-Item Env:DATABASE_URL -ErrorAction SilentlyContinue
    }
    try {
        & powershell -NoProfile -ExecutionPolicy Bypass -File $script -Port 8000
    }
    catch {
        if (Test-TesteInterfaceOnline) {
            Write-Host "Aviso: teste de interface ja esta online por processo externo. Seguindo."
            return
        }
        throw
    }
}

function Start-SdrsManager {
    param([switch]$Restart)

    if (-not $Restart -and (Test-SdrsOnline)) {
        Write-Host "SDRS ja esta online. Seguindo."
        return
    }

    $script = Join-Path $Root "sdrs-manager\start.ps1"
    if (-not (Test-Path $script)) {
        throw "Script nao encontrado: $script"
    }

    try {
        if ($Restart) {
            & powershell -NoProfile -ExecutionPolicy Bypass -File $script -BackendPort 8010 -FrontendPort 5500 -ForceRestart
        }
        else {
            & powershell -NoProfile -ExecutionPolicy Bypass -File $script -BackendPort 8010 -FrontendPort 5500
        }
    }
    catch {
        if (Test-SdrsOnline) {
            Write-Host "Aviso: SDRS ja esta online por processo externo. Seguindo."
            return
        }
        throw
    }
}

if ($ForceRestart) {
    $stopScript = Join-Path $Root "stop_hub.ps1"
    if (Test-Path $stopScript) {
        & powershell -NoProfile -ExecutionPolicy Bypass -File $stopScript
    }
}

if (-not $SkipApps) {
    Ensure-ProjetoCompleto
    Start-TesteInterface
    Start-SdrsManager -Restart:$ForceRestart
}

Ensure-HubServer -Port $HubPort

Write-Host ""
Write-Host "MHUB pronto."
Write-Host "Portal: http://127.0.0.1:$HubPort/index.html"
Write-Host "Apps:"
Write-Host " - newaopro:                  http://127.0.0.1:$NewAoproFrontendPort"
Write-Host " - newaopro backend:          http://127.0.0.1:$NewAoproBackendPort/health"
Write-Host " - teste de interface:       http://127.0.0.1:8000"
Write-Host " - sdrs-manager frontend:    http://127.0.0.1:5500/index.html"
Write-Host " - sdrs-manager backend:     http://127.0.0.1:8010/api/health"
