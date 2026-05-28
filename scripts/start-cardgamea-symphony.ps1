param(
    [int]$Port = 4000,
    [switch]$PreflightOnly
)

$ErrorActionPreference = "Stop"

$symphonyLocal = "Q:\codex\.omx\symphony-local"
$configureScript = Join-Path $symphonyLocal "configure-symphony.ps1"
$startScript = Join-Path $symphonyLocal "start-symphony.ps1"
$workflowPath = Join-Path $symphonyLocal "WORKFLOW.cardgamea.generated.md"
$workspaceRoot = "Q:\codex\.omx\workspaces-cardgamea"

if (-not (Test-Path $configureScript)) {
    throw "Symphony configure script not found: $configureScript"
}

if (-not (Test-Path $startScript)) {
    throw "Symphony start script not found: $startScript"
}

& $configureScript `
    -OutputPath $workflowPath `
    -ProjectSlug "cardgamea-3f851a07e18a" `
    -SourceRepoUrl "https://github.com/lacsclyne/cardgamebiga.git" `
    -WorkspaceRoot $workspaceRoot `
    -Port $Port | Out-Null

if ($PreflightOnly) {
    & $startScript -WorkflowPath $workflowPath -Port $Port -PreflightOnly
}
else {
    & $startScript -WorkflowPath $workflowPath -Port $Port
}
