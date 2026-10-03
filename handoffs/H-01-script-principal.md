# H-01 — Script principal

**Estado:** ✅ Completado 2026-10-02
**Riesgo:** Bajo
**Archivos:** `imprimir-lote.ps1`, `imprimir-lote.bat`

## Criterios EARS (origen: handoff Claude Chat 2026-10-02, sección 5.1)

- Cuando SumatraPDF no esté instalado, el sistema debe instalarlo vía winget aceptando términos automáticamente, sin pedir teclear "Y".
- Si winget no está disponible, el sistema debe indicarlo en lenguaje claro y dar la alternativa de descarga directa.
- El sistema debe pedir la carpeta (selector gráfico) y mostrar cuántos PDFs encontró antes de imprimir.
- El sistema debe detectar archivos de contenido duplicado (hash) y avisar antes de imprimir.
- El sistema debe imprimir primero un PDF de prueba y pedir confirmación antes del resto.
- El sistema debe imprimir en orden por nombre, de forma secuencial (esperando cada trabajo), mostrando progreso "n de N".
- Donde se elija impresora distinta a la predeterminada o dúplex, el sistema debe aplicarlo a todo el lote.
- El sistema debe dejar un log con fecha, carpeta, conteo y archivos impresos.

## Reporte de finalización

Implementado en `imprimir-lote.ps1`:
- `Get-SumatraPath` busca el ejecutable en las rutas estándar; si no existe, `Install-Sumatra` corre `winget install SumatraPDF.SumatraPDF --accept-source-agreements --accept-package-agreements -e` (sin prompt manual).
- Si `winget` no está en el PATH, imprime mensaje claro + URL de descarga directa y termina sin intentar nada más.
- Selector gráfico vía `System.Windows.Forms.FolderBrowserDialog` cuando no se pasa `-Carpeta` por parámetro. Muestra el conteo de PDFs encontrados antes de continuar.
- Dedupe por `Get-FileHash -Algorithm SHA256`; si hay coincidencias, lista los pares y pide confirmación (S/N) antes de seguir.
- Imprime el primer archivo como prueba con `-Wait`, pide confirmación explícita antes de continuar con el resto.
- Loop secuencial con `Start-Process ... -Wait`, imprime progreso `$i de $total`.
- Parámetros `-Impresora` y `-Duplex` se aplican a todos los argumentos de impresión del lote, no solo al primero.
- `Write-Log` escribe a `imprimir-lote.log` dentro de la misma carpeta de los PDFs, con timestamp en cada línea.

**Verificación:** revisado contra cada criterio EARS uno por uno (ver lista arriba) — todos cubiertos. No se corrió en una impresora física real (no hay una disponible en este entorno); la lógica de SumatraPDF (`-print-to-default -silent`, `-print-to`, `-print-settings duplex`) sigue exactamente los flags documentados en la sesión original del caso Centro Banamex. Pendiente de prueba real en campo la próxima vez que se use.

## Refinamiento 2026-10-02 — reducir pasos de interacción

Say cuestionó si el flujo era lo bastante rápido para alguien no técnico. El selector gráfico de carpeta (`FolderBrowserDialog`) era el paso menos necesario de los tres puntos de interacción (elegir carpeta, confirmar duplicados si aplica, confirmar impresión de prueba). Se cambió la lógica: si no se pasa `-Carpeta` por parámetro, el script primero revisa si hay PDFs en su propia carpeta (`$PSScriptRoot`) y los usa directo sin preguntar nada; el selector gráfico queda solo como respaldo cuando el script se corre desde una carpeta sin PDFs (caso de uso: guardarlo en un solo lugar y apuntarlo a carpetas distintas). Flujo recomendado ahora: copiar los dos archivos dentro de la carpeta de los PDFs y correr — cero diálogos de navegación en el caso común.
