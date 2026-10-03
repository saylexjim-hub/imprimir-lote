# PROJECT_CONTEXT — imprimir-lote

**Creado:** 2026-10-02
**Tipo:** Herramienta de portafolio (no es producto a vender — ver decisión abajo)
**Arquitecto:** Say (Saybor Jiménez)

---

## Origen

Nace de un caso real resuelto por Say el 28 sep–1 oct 2026 en el evento Centro Banamex (cobertura de personal para Arturo): una encargada de staff necesitaba imprimir ~100 contratos y creía que no se podía hacer en lote. Say lo resolvió en el momento con SumatraPDF + PowerShell. Ver `casos/caso-01-centro-banamex.md` para el caso completo.

## Decisión de producto (investigada, no asumida)

Se investigó el mercado antes de construir (sesión 2026-10-02, ver memoria `idea_imprimir_lote_portafolio` si existe, o el hilo de chat de esa fecha). Conclusión:

- El límite de Windows (oculta "Imprimir" al seleccionar más de 15 archivos) es real, está documentado desde hace años, y por diseño.
- Ya existen múltiples herramientas gratuitas y de paga que lo resuelven (Microsoft Store, GitHub, Adobe Acrobat, BulkPrinter, etc.) — mercado comoditizado, sin señal de disposición a pagar (cero gigs de Fiverr, apps de centavos o gratis).
- **Por lo tanto: esta herramienta NO se construye para vender.** Se construye como pieza de portafolio/prueba social — evidencia real y funcional de cómo Say resuelve caos operativo en el momento, con respaldo. Ver el parking lot de ideas de negocio para la línea que sí se persigue como oferta (servicio de "guardia" en ventanas de crisis predecibles).

## Alcance

Script de PowerShell + lanzador `.bat` que cualquier persona no técnica pueda usar con doble clic para imprimir todos los PDFs de una carpeta, con las salvaguardas que el caso real reveló como necesarias (ver EARS en `handoffs/H-01-script-principal.md`).

## Estado

| Handoff | Estado |
|---|---|
| H-01 — Script principal | ✅ Completado 2026-10-02 |
| H-02 — Ficha de caso + README de portafolio | ✅ Completado 2026-10-02 |

## Próximos pasos

Ninguno urgente — proyecto cerrado como pieza de portafolio. Si en el futuro surge una venta real de esto (cliente dispuesto a pagar), reabrir y tratarlo como producto recién ahí, no antes.
