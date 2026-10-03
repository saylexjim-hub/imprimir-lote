# imprimir-lote

¿Tenés una carpeta con muchos PDFs (contratos, facturas, boletas) y Windows no te deja seleccionarlos todos para imprimir? Es un límite de Windows, no un error tuyo — a partir de 16 archivos, Windows oculta la opción "Imprimir" a propósito.

Este script lo resuelve: imprime todos los PDFs de una carpeta, uno por uno, de forma segura.

## Cómo usarlo

1. Descargá los dos archivos desde [la última versión](../../releases/latest): `imprimir-lote.bat` e `imprimir-lote.ps1`.
2. Copialos **dentro de la misma carpeta donde están tus PDFs**.
3. Hacé doble clic en **`imprimir-lote.bat`**.
4. **Windows va a mostrar una pantalla azul que dice "Windows protegió tu PC".** Esto es normal — pasa con cualquier programa nuevo que no sea de una tienda oficial, no significa que algo esté mal. Hacé clic en **"Más información"** y después en **"Ejecutar de todas formas"**.
5. El script arranca solo, sin preguntarte dónde están los PDFs (ya los encontró en su propia carpeta):
   - instala el lector necesario (SumatraPDF) si no lo tenés — gratis y sin publicidad,
   - te dice cuántos PDFs encontró,
   - te avisa si hay archivos repetidos,
   - imprime uno de prueba y te pregunta si salió bien antes de imprimir el resto,
   - deja un registro (`imprimir-lote.log`) de todo lo que imprimió.

¿Preferís tener el script guardado en un solo lugar y usarlo contra distintas carpetas sin copiarlo cada vez? Si lo corrés desde una carpeta sin PDFs, se abre un selector para que elijas cuál usar — es el único caso en el que te pregunta.

No necesitás saber de computadoras para usarlo — solo seguir lo que te va preguntando en pantalla. Si te saltaste el paso 4 y no pasó nada al hacer doble clic, revisá si la pantalla azul se abrió detrás de otras ventanas.

## Por qué existe

Nació de un caso real: ~100 contratos atorados durante un evento, una persona con años de experiencia convencida de que "no se podía", y una solución armada en el momento con respaldo. Está documentado completo en [`casos/caso-01-centro-banamex.md`](casos/caso-01-centro-banamex.md).

## Para quién es esto

No es un producto que se vende — es una herramienta gratuita y una muestra de cómo se resuelven estos problemas en el momento, no después. Si tenés un caos similar (impresión masiva, cierres de mes, auditorías), contactame.
