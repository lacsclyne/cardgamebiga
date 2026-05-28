param(
    [int]$Port = 4100,
    [switch]$PreflightOnly,
    [Parameter(ValueFromRemainingArguments = $true)]
    [string[]]$ExtraArgs
)

$ErrorActionPreference = "Stop"

$projectSlug = "cardgamea-3f851a07e18a"
$sourceRepoUrl = "https://github.com/lacsclyne/cardgamebiga.git"

$omxRoot = "Q:\codex\.omx"
$symphonyLocal = Join-Path $omxRoot "symphony-local"
$symphonyRoot = Join-Path $omxRoot "vendor\symphony\elixir"
$symphonyBin = Join-Path $symphonyRoot "bin\symphony"
$configureScript = Join-Path $symphonyLocal "configure-symphony.ps1"

$runtimeRoot = Join-Path $omxRoot "projects\cardgamea"
$workflowPath = Join-Path $runtimeRoot "WORKFLOW.generated.md"
$workspaceRoot = Join-Path $runtimeRoot "workspaces"
$logsRoot = Join-Path $runtimeRoot "logs"
$tempRoot = Join-Path $runtimeRoot "tmp"
$makeCache = Join-Path $tempRoot "elixir-make-cache"

$localEnvScript = Join-Path $symphonyLocal ".env.ps1"
if (Test-Path $localEnvScript) {
    . $localEnvScript
}

$gitBin = "Q:\Git\bin"
$otpBin = Join-Path $env:USERPROFILE ".elixir-install\installs\otp\28.1\bin"
$elixirBin = Join-Path $env:USERPROFILE ".elixir-install\installs\elixir\1.19.5-otp-28\bin"
$ghBin = "C:\Program Files\GitHub CLI"
$uvBin = Join-Path $env:USERPROFILE "AppData\Local\Microsoft\WinGet\Links"

$pathSegments = @($gitBin, $otpBin, $elixirBin, $ghBin, $uvBin, $env:PATH) |
    Where-Object { -not [string]::IsNullOrWhiteSpace($_) }
$env:PATH = ($pathSegments -join ";")
$env:TEMP = $tempRoot
$env:TMP = $tempRoot
$env:ELIXIR_MAKE_CACHE_DIR = $makeCache

foreach ($directory in @($runtimeRoot, $workspaceRoot, $logsRoot, $tempRoot, $makeCache)) {
    New-Item -ItemType Directory -Force -Path $directory | Out-Null
}

if (-not (Test-Path $configureScript)) {
    throw "Symphony configure script not found: $configureScript"
}

if (-not (Test-Path $symphonyBin)) {
    throw "Symphony binary not found: $symphonyBin"
}

& $configureScript `
    -OutputPath $workflowPath `
    -ProjectSlug $projectSlug `
    -SourceRepoUrl $sourceRepoUrl `
    -WorkspaceRoot $workspaceRoot `
    -Port $Port | Out-Null

if (-not (Test-Path $workflowPath)) {
    throw "Workflow file not found: $workflowPath"
}

if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    throw "git is required but was not found in PATH."
}

if (-not (Get-Command escript -ErrorAction SilentlyContinue)) {
    throw "escript is required but was not found in PATH."
}

if (-not (Get-Command gh -ErrorAction SilentlyContinue)) {
    throw "gh is required by the upstream Symphony GitHub workflow but was not found in PATH."
}

$ghStatusOutput = & cmd.exe /d /c "gh auth status 2>&1"
$ghStatusExitCode = $LASTEXITCODE

if ($ghStatusExitCode -ne 0) {
    $statusText = ($ghStatusOutput | Out-String).Trim()
    throw "gh is installed but not authenticated. Run 'gh auth login' before starting Symphony. Details: $statusText"
}

if ($PreflightOnly) {
    Write-Output "CardGameA Symphony preflight passed."
    Write-Output "Runtime root: $runtimeRoot"
    Write-Output "Workflow: $workflowPath"
    Write-Output "Workspaces: $workspaceRoot"
    Write-Output "Logs: $logsRoot"
    Write-Output "Temp: $tempRoot"
    Write-Output "Dashboard: http://127.0.0.1:$Port/"
    return
}

$runtimeArgs = @($workflowPath, "--logs-root", $logsRoot, "--port", [string]$Port)
if ($ExtraArgs) {
    $runtimeArgs += $ExtraArgs
}

& escript $symphonyBin @runtimeArgs
