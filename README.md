# imprimir-lote

¿Tienes una carpeta con muchos PDFs (contratos, facturas, boletas) y Windows no te deja seleccionarlos todos para imprimir? Es un límite de Windows, no un error tuyo: a partir de 16 archivos, Windows oculta la opción "Imprimir" a propósito.

Este script lo resuelve: imprime todos los PDFs de una carpeta, uno por uno, de forma segura.

## Cómo usarlo

1. Descarga los dos archivos desde [la última versión](../../releases/latest): `imprimir-lote.bat` e `imprimir-lote.ps1`. Guárdalos en la misma carpeta.
2. Haz doble clic en **`imprimir-lote.bat`**.
3. **Windows va a mostrar una pantalla azul que dice "Windows protegió tu PC".** Esto es normal: pasa con cualquier programa nuevo que no viene de una tienda oficial, no significa que algo esté mal. Haz clic en **"Más información"** y después en **"Ejecutar de todas formas"**.
4. Se abre una ventana para elegir la carpeta con tus PDFs. Selecciónala y dale **Aceptar**. El script:
   - instala el lector necesario (SumatraPDF) si no lo tienes; es gratis y sin publicidad,
   - te dice cuántos PDFs encontró,
   - te avisa si hay archivos repetidos,
   - imprime uno de prueba y te pregunta si salió bien antes de imprimir el resto,
   - deja un registro (`imprimir-lote.log`) de todo lo que imprimió.

No necesitas saber de computadoras para usarlo: solo sigue lo que te va preguntando en pantalla. Si hiciste doble clic y no pasó nada, revisa si la pantalla azul se abrió detrás de otras ventanas.

## Por qué existe

Nació de un caso real: unos 100 contratos atorados durante un evento, una persona con años de experiencia convencida de que "no se podía", y una solución armada en el momento con respaldo. Está documentado completo en [`casos/caso-01-centro-banamex.md`](casos/caso-01-centro-banamex.md).

## Para quién es esto

No es un producto que se vende. Es una herramienta gratuita y una muestra de cómo se resuelven estos problemas en el momento, no después. Si tienes un caos similar (impresión masiva, cierres de mes, auditorías), escríbeme.
