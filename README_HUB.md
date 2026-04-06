# MHUB

Hub local para abrir e operar as 3 aplicacoes em conjunto:

- `projeto_completo_producao` (Flask) em `http://127.0.0.1:5000`
- `teste de interface` (FastAPI) em `http://127.0.0.1:8000`
- `sdrs-manager` (frontend + backend) em `http://127.0.0.1:5500` e `http://127.0.0.1:8010`

## Arquivos criados

- `hub/index.html`: portal web com links e status.
- `start_hub.ps1`: inicia apps e portal.
- `stop_hub.ps1`: para apps e portal.

## Como usar

No PowerShell, a partir da raiz `MHUB`:

```powershell
powershell -ExecutionPolicy Bypass -File .\start_hub.ps1
```

Portal:

- `http://127.0.0.1:5600/index.html`

Parar tudo:

```powershell
powershell -ExecutionPolicy Bypass -File .\stop_hub.ps1
```

## Opcoes uteis

Subir so o portal (sem apps):

```powershell
powershell -ExecutionPolicy Bypass -File .\start_hub.ps1 -SkipApps
```

Reiniciar stack completa:

```powershell
powershell -ExecutionPolicy Bypass -File .\start_hub.ps1 -ForceRestart
```

Trocar porta do portal:

```powershell
powershell -ExecutionPolicy Bypass -File .\start_hub.ps1 -HubPort 5601
```
