# imprimir-lote

¿Tenés una carpeta con muchos PDFs (contratos, facturas, boletas) y Windows no te deja seleccionarlos todos para imprimir? Es un límite de Windows, no un error tuyo — a partir de 16 archivos, Windows oculta la opción "Imprimir" a propósito.

Este script lo resuelve: imprime todos los PDFs de una carpeta, uno por uno, de forma segura.

## Cómo usarlo

1. Descargá o cloná este repositorio.
2. Hacé doble clic en **`imprimir-lote.bat`**.
3. Seleccioná la carpeta con tus PDFs cuando se abra la ventana. El script:
   - instala el lector necesario (SumatraPDF) si no lo tenés — gratis y sin publicidad,
   - te dice cuántos PDFs encontró,
   - te avisa si hay archivos repetidos,
   - imprime uno de prueba y te pregunta si salió bien antes de imprimir el resto,
   - deja un registro (`imprimir-lote.log`) de todo lo que imprimió.

No necesitás saber de computadoras para usarlo — solo seguir lo que te va preguntando en pantalla.

## Por qué existe

Nació de un caso real: ~100 contratos atorados durante un evento, una persona con años de experiencia convencida de que "no se podía", y una solución armada en el momento con respaldo. Está documentado completo en [`casos/caso-01-centro-banamex.md`](casos/caso-01-centro-banamex.md).

## Para quién es esto

No es un producto que se vende — es una herramienta gratuita y una muestra de cómo se resuelven estos problemas en el momento, no después. Si tenés un caos similar (impresión masiva, cierres de mes, auditorías), contactame.
