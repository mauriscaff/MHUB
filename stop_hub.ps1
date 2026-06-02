param()

$ErrorActionPreference = "Stop"

$Root = $PSScriptRoot
$RuntimeDir = Join-Path $Root ".hub-runtime"
$HubPidFile = Join-Path $RuntimeDir "hub_server.pid"
$ProjetoPidFile = Join-Path $RuntimeDir "projeto_completo.pid"
$NewAoproDir = "C:\Users\mscaff\Documents\newaopro"
$NewAoproFrontendPidFile = Join-Path $RuntimeDir "newaopro_frontend.pid"
$NewAoproBackendPidFile = Join-Path $RuntimeDir "newaopro_backend.pid"

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
    param(
        [int]$ProcessId,
        [string]$Label
    )
    $proc = Get-Process -Id $ProcessId -ErrorAction SilentlyContinue
    if ($proc) {
        try {
            Stop-Process -Id $ProcessId -Force
            Write-Host "${Label}: processo $ProcessId finalizado."
        }
        catch {
            Write-Host "${Label}: falha ao encerrar $ProcessId ($($_.Exception.Message))."
        }
    }
}

function Is-ProjetoCompletoProcess {
    param([int]$PidCandidate)
    try {
        $proc = Get-CimInstance Win32_Process -Filter "ProcessId = $PidCandidate" -ErrorAction Stop
        if (-not $proc) { return $false }
        $cmd = [string]$proc.CommandLine
        if (-not $cmd) { return $false }
        return (
            $cmd -match "(?i)dashboard_api\.py" -or
            $cmd -match "(?i)uvicorn\s+app\.main:app" -or
            $cmd -match "(?i)newaopro" -or
            $cmd -match "(?i)\bvite(\.js)?\b"
        )
    }
    catch {
        return $false
    }
}

function Is-HubHttpServerProcess {
    param([int]$PidCandidate)
    try {
        $proc = Get-CimInstance Win32_Process -Filter "ProcessId = $PidCandidate" -ErrorAction Stop
        if (-not $proc) { return $false }
        $cmd = [string]$proc.CommandLine
        if (-not $cmd) { return $false }
        return ($cmd -match "(?i)-m\s+http\.server")
    }
    catch {
        return $false
    }
}

function Stop-FromPidFile {
    param(
        [string]$Label,
        [string]$PidFile
    )
    $pidValue = Read-PidFile -PidFile $PidFile
    if ($pidValue) {
        Stop-ProcessSafe -ProcessId $pidValue -Label $Label
    }
    if (Test-Path $PidFile) {
        Remove-Item $PidFile -Force -ErrorAction SilentlyContinue
    }
}

function Stop-ProjetoCompletoFallback {
    foreach ($port in @(5000, 5001)) {
        $pids = @(Get-ListeningPids -Port $port)
        foreach ($pidValue in $pids) {
            if (Is-ProjetoCompletoProcess -PidCandidate $pidValue) {
                Stop-ProcessSafe -ProcessId $pidValue -Label "newaopro(porta $port)"
            }
        }
    }
}

function Stop-HubFallback {
    $pids = @(Get-ListeningPids -Port 5600)
    foreach ($pidValue in $pids) {
        if (Is-HubHttpServerProcess -PidCandidate $pidValue) {
            Stop-ProcessSafe -ProcessId $pidValue -Label "hub(porta 5600)"
        }
    }
}

$stopTeste = Join-Path $Root "teste de interface\stop.ps1"
if (Test-Path $stopTeste) {
    & powershell -NoProfile -ExecutionPolicy Bypass -File $stopTeste
}

$stopSdrs = Join-Path $Root "sdrs-manager\stop.ps1"
if (Test-Path $stopSdrs) {
    & powershell -NoProfile -ExecutionPolicy Bypass -File $stopSdrs -BackendPort 8010 -FrontendPort 5500
}

Stop-FromPidFile -Label "newaopro backend" -PidFile $NewAoproBackendPidFile
Stop-FromPidFile -Label "newaopro frontend" -PidFile $NewAoproFrontendPidFile
Remove-Item $ProjetoPidFile -Force -ErrorAction SilentlyContinue
Stop-ProjetoCompletoFallback

Stop-FromPidFile -Label "hub portal" -PidFile $HubPidFile
Stop-HubFallback

Write-Host "MHUB parado."
