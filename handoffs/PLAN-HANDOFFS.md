# Plan Maestro — imprimir-lote
**Creado:** 2026-10-02
**Orquestador:** Say
**Base:** Handoff de Claude Chat 2026-10-02 (caso Centro Banamex), sección 5.1

---

## Estado General

- **Fase actual:** Construcción inicial — pieza de portafolio, no producto
- **Sistema en producción:** No aplica (herramienta local de un solo archivo, sin backend)

---

## Tabla de Handoffs

| ID | Nombre | Estado | Dependencia | Riesgo | Archivos clave |
|----|--------|--------|-------------|--------|----------------|
| H-01 | Script principal (`imprimir-lote.ps1` + `.bat`) | ✅ Completado 2026-10-02 | Ninguna | Bajo | `imprimir-lote.ps1`, `imprimir-lote.bat` |
| H-02 | Ficha de caso + README de portafolio | ✅ Completado 2026-10-02 | Ninguna | Bajo | `casos/caso-01-centro-banamex.md`, `README.md` |

## Reglas del Proceso

Mismas reglas que el resto de los proyectos de Say (Protocolo Sistémico de Desarrollo v3.1):
1. Ningún handoff comienza sin que el anterior esté verificado.
2. Criterios EARS antes de código — ver cada handoff individual.
3. Loop PIV: plan en texto → aprobación → implementar → verificar.
4. Prohibido commit/push/deploy sin instrucción explícita del Orquestador — **ya autorizado para este repo el 2026-10-02** ("comencemos creando el proyecto en github... que tengamos ese repo público").
