<#
.SYNOPSIS
    Imprime en lote todos los PDFs de una carpeta, de forma segura y secuencial.

.DESCRIPTION
    Windows oculta la opción "Imprimir" del menú contextual cuando seleccionas más de 15 archivos
    (es un límite por diseño, no un bug). Este script lo evita usando SumatraPDF para imprimir
    cada PDF uno por uno, con verificaciones antes de lanzar el lote completo.

.PARAMETER Carpeta
    Carpeta con los PDFs a imprimir. Si no se indica, se abre un selector de carpetas.

.PARAMETER Impresora
    Nombre de una impresora distinta a la predeterminada. Opcional.

.PARAMETER Duplex
    Si se indica, imprime a doble cara en todo el lote.
#>

[CmdletBinding()]
param(
    [string]$Carpeta,
    [string]$Impresora,
    [switch]$Duplex
)

$ErrorActionPreference = "Stop"

function Write-Log {
    param([string]$Mensaje)
    $linea = "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') | $Mensaje"
    Write-Host $linea
    Add-Content -Path $script:LogPath -Value $linea
}

function Get-SumatraPath {
    $candidatos = @(
        "$env:LOCALAPPDATA\SumatraPDF\SumatraPDF.exe",
        "$env:ProgramFiles\SumatraPDF\SumatraPDF.exe",
        "${env:ProgramFiles(x86)}\SumatraPDF\SumatraPDF.exe"
    )
    foreach ($c in $candidatos) {
        if (Test-Path $c) { return $c }
    }
    return $null
}

function Install-Sumatra {
    if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
        Write-Host ""
        Write-Host "No se encontró 'winget' en este equipo." -ForegroundColor Yellow
        Write-Host "Descarga SumatraPDF manualmente desde:"
        Write-Host "  https://www.sumatrapdfreader.org/download-free-pdf-viewer" -ForegroundColor Yellow
        Write-Host "Instálalo y vuelve a correr este script."
        exit 1
    }
    Write-Host "Instalando SumatraPDF..."
    winget install SumatraPDF.SumatraPDF --accept-source-agreements --accept-package-agreements -e
}

if (-not $Carpeta) {
    Add-Type -AssemblyName System.Windows.Forms
    $dialog = New-Object System.Windows.Forms.FolderBrowserDialog
    $dialog.Description = "Selecciona la carpeta con los PDFs a imprimir"
    if ($dialog.ShowDialog() -ne [System.Windows.Forms.DialogResult]::OK) {
        Write-Host "Cancelado."
        exit 0
    }
    $Carpeta = $dialog.SelectedPath
}

if (-not (Test-Path $Carpeta)) {
    Write-Host "La carpeta '$Carpeta' no existe." -ForegroundColor Red
    exit 1
}

$script:LogPath = Join-Path $Carpeta "imprimir-lote.log"
Write-Log "=== Sesión iniciada - carpeta: $Carpeta ==="

$sumatra = Get-SumatraPath
if (-not $sumatra) {
    Install-Sumatra
    $sumatra = Get-SumatraPath
    if (-not $sumatra) {
        Write-Host "No se pudo localizar SumatraPDF tras la instalación. Instálalo manualmente y reintenta." -ForegroundColor Red
        Write-Log "ERROR: SumatraPDF no disponible tras intento de instalación."
        exit 1
    }
}
Write-Log "SumatraPDF localizado en: $sumatra"

$pdfs = Get-ChildItem -Path $Carpeta -Filter *.pdf -File | Sort-Object Name
if ($pdfs.Count -eq 0) {
    Write-Host "No se encontraron archivos PDF en '$Carpeta'."
    Write-Log "Sin PDFs encontrados. Fin."
    exit 0
}

Write-Host ""
Write-Host "Se encontraron $($pdfs.Count) archivos PDF en '$Carpeta'." -ForegroundColor Cyan
Write-Log "PDFs encontrados: $($pdfs.Count)"

Write-Host "Verificando archivos duplicados..."
$hashes = @{}
$duplicados = @()
foreach ($pdf in $pdfs) {
    $h = (Get-FileHash -Path $pdf.FullName -Algorithm SHA256).Hash
    if ($hashes.ContainsKey($h)) {
        $duplicados += "  - $($pdf.Name)  ==  $($hashes[$h])"
    } else {
        $hashes[$h] = $pdf.Name
    }
}
if ($duplicados.Count -gt 0) {
    Write-Host ""
    Write-Host "ATENCIÓN: se encontraron archivos con el mismo contenido (posibles duplicados):" -ForegroundColor Yellow
    $duplicados | ForEach-Object { Write-Host $_ -ForegroundColor Yellow }
    Write-Log "Duplicados detectados: $($duplicados.Count)"
    $resp = Read-Host "¿Continuar de todas formas? (S/N)"
    if ($resp -notmatch '^[sS]') {
        Write-Host "Cancelado por el usuario."
        Write-Log "Cancelado por el usuario tras aviso de duplicados."
        exit 0
    }
}

$printArgs = @("-print-to-default", "-silent")
if ($Impresora) {
    $printArgs = @("-print-to", $Impresora, "-silent")
}
if ($Duplex) {
    $printArgs += "-print-settings"
    $printArgs += "duplex"
}

Write-Host ""
Write-Host "Imprimiendo PRUEBA con el primer archivo: $($pdfs[0].Name)" -ForegroundColor Cyan
Start-Process -FilePath $sumatra -ArgumentList ($printArgs + "`"$($pdfs[0].FullName)`"") -Wait
Write-Log "Impresión de prueba: $($pdfs[0].Name)"

$resp = Read-Host "¿Salió bien la impresión de prueba? Escribe S para imprimir el resto, cualquier otra tecla para detener"
if ($resp -notmatch '^[sS]') {
    Write-Host "Detenido tras la prueba."
    Write-Log "Detenido por el usuario tras la prueba."
    exit 0
}

$total = $pdfs.Count
for ($i = 1; $i -lt $total; $i++) {
    $pdf = $pdfs[$i]
    Write-Host "Imprimiendo $($i + 1) de $total - $($pdf.Name)"
    Start-Process -FilePath $sumatra -ArgumentList ($printArgs + "`"$($pdf.FullName)`"") -Wait
    Write-Log "Impreso ($($i + 1)/$total): $($pdf.Name)"
}

Write-Host ""
Write-Host "Listo. Se imprimieron $total archivos." -ForegroundColor Green
Write-Log "=== Fin de sesión - $total archivos impresos ==="
