# Custom Agent AGY - Automated Global Setup Script for Windows (PowerShell)
# Installs all 8 custom agents into ~/.gemini/config/agents/ for Antigravity CLI

$ErrorActionPreference = "Stop"
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$repoDir = Split-Path -Parent $scriptDir
$globalConfigAgentsDir = Join-Path $env:USERPROFILE ".gemini\config\agents"

$agents = @(
    "ba-requirements-specialist",
    "api-db-architect",
    "qc-verification-specialist",
    "codebase-researcher",
    "dev-security-implementer",
    "logging-observability-specialist",
    "docs-readme-specialist",
    "devops-git-specialist"
)

Write-Host "==================================================" -ForegroundColor Cyan
Write-Host " Custom Agent AGY -- Automated Global Installation " -ForegroundColor Cyan
Write-Host "==================================================" -ForegroundColor Cyan
Write-Host "Target Directory: $globalConfigAgentsDir`n" -ForegroundColor Yellow

foreach ($agent in $agents) {
    $srcFile = Join-Path $repoDir "$agent.md"
    if (!(Test-Path $srcFile)) {
        Write-Host "[ERROR] Missing agent source file: $srcFile" -ForegroundColor Red
        continue
    }

    $targetFolder = Join-Path $globalConfigAgentsDir $agent
    if (!(Test-Path $targetFolder)) {
        New-Item -ItemType Directory -Path $targetFolder -Force | Out-Null
    }

    $targetFile = Join-Path $targetFolder "agent.md"
    Copy-Item $srcFile $targetFile -Force
    Write-Host "[OK] Installed $agent -> $targetFile" -ForegroundColor Green
}

Write-Host "`n[SUCCESS] All 8 custom agents installed globally!" -ForegroundColor Green
Write-Host "Launch Antigravity CLI and type /agents to view and switch between custom agents." -ForegroundColor Yellow
