# Caso 01 — Impresión masiva de contratos, Centro Banamex

**Fecha:** 28 sep – 1 oct 2026
**Contexto de Say:** cubriendo personal para Arturo, supervisando entrega y funcionamiento de nodos de internet según manual del evento.

## Contexto

Durante el evento, los contratos de personal (staff) de otra área estaban atrasados. Había gente esperando para cobrar cheques y el caos iba en aumento. No era parte del área de Say — lo resolvió de todas formas.

## Problema

La encargada del área, con años de experiencia haciendo esto, daba por hecho que los contratos solo se podían imprimir uno por uno. Con decenas de documentos pendientes, eso significaba horas de trabajo manual mientras la gente esperaba.

## Solución

**Movimiento inicial:** "déjame resolverlo en un jalón; si no sale, empiezo manual" — un experimento con respaldo cubierto, sin riesgo real si fallaba.

**Técnica:**
1. Windows oculta "Imprimir" del menú contextual cuando se seleccionan más de 15 archivos (límite por diseño, no bug).
2. No había lector de PDF instalado en el equipo → se instaló SumatraPDF vía `winget install SumatraPDF.SumatraPDF --accept-source-agreements --accept-package-agreements`.
3. Se contaron los PDFs, se probó con uno solo, y luego se imprimieron todos con los flags `-print-to-default -silent`.
4. Tropiezos resueltos en el momento: confusión CMD vs. PowerShell (verificar que el prompt empiece con `PS`), impresiones que parecían duplicadas verificadas con `Get-FileHash`, impresión secuencial con `Start-Process ... -Wait` para no saturar la cola.

**Organizacional:** Say pidió personal dedicado solo a ordenar y engrapar los contratos conforme salían de la impresora, en paralelo a la impresión.

## Resultado en números

~100 contratos impresos en menos de una hora, desde el momento en que se identificó el bloqueo.

## Dónde más aplica

Cualquier oficina/área administrativa que reciba lotes de documentos (contratos, nóminas, formatos) y no tenga el conocimiento técnico para imprimirlos de golpe: despachos contables, RH, escuelas (boletas), notarías. Ver `imprimir-lote.ps1` en este mismo repo — empaqueta esta misma solución para que cualquiera la use con doble clic, sin tener que saber PowerShell.
