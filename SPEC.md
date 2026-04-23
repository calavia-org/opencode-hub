# SPEC: Context7 Integration

## Metadata

| Field | Value |
|-------|-------|
| **Issue** | #4 |
| **Status** | Draft |
| **Priority** | Medium |
| **Type** | Feature |
| **Created** | 2026-04-23 |
| **Review** | Pending |

## 1. Overview

Integrar Context7 MCP en OpenCode para proporcionar documentación actualizada y específica de librerías directamente en tiempo de codificación.

## 2. Problem Statement

Sin Context7, los agentes de IA usan:
- Documentación obsoleta (training data desactualizado)
- Alucinaciones de API (código que no existe o está deprecated)
- Ejemplos genéricos que no corresponden a la versión actual

**Impacto**: Código incorrecto, bugs evitables, pérdida de tiempo.

## 3. Requirements

### 3.1 Core Requirements

- [ ] Configurar Context7 MCP en `opencode.json`
- [ ] Autenticación via `CONTEXT7_API_KEY` env var
- [ ] Verificar conectividad con endpoint MCP
- [ ] Skills/documentación de uso para agentes

### 3.2 Technical Requirements

- [ ] Remote MCP server: `https://mcp.context7.com/mcp`
- [ ] Headers: `CONTEXT7_API_KEY`
- [ ] Fallback si MCP no disponible (CLI skill)

### 3.3 Integration Requirements

- [ ] Integrar con `spec-driven` agent
- [ ] Integrar con `*[lang]-implementer` agents
- [ ] Ejemplos de uso documentados

## 4. Acceptance Criteria

| ID | Criterion | Test |
|----|-----------|------|
| AC1 | MCP conecta a Context7 | `curl` a endpoint retorna 200 |
| AC2 | `resolve-library-id` funciona | `react` → `/facebook/react/docs` |
| AC3 | `query-docs` devuelve docs aktuales | Docs version-specific |
| AC4 | Docs accesibles a implementer | Prompt incluye docs relevantes |
| AC5 | Fallback CLI funciona | `ctx7 docs` sin MCP |

## 5. Tasks

### Phase 1: Configuration

- [ ] T1: Add Context7 MCP config to `opencode.json`
- [ ] T2: Document setup con `CONTEXT7_API_KEY`
- [ ] T3: Test MCP connectivity

### Phase 2: Integration

- [ ] T4: Create Context7 skill para agents
- [ ] T5: Integrate con spec-driven
- [ ] T6: Test with real queries

### Phase 3: Examples

- [ ] T7: Example with React queries
- [ ] T8: Example with Go queries
- [ ] T9: Example with Python queries

### Phase 4: Documentation

- [ ] T10: Update README with Context7 usage
- [ ] T11: Create usage examples in docs

## 6. Technical Notes

### MCP Configuration

```json
{
  "mcp": {
    "context7": {
      "type": "remote",
      "url": "https://mcp.context7.com/mcp",
      "headers": {
        "CONTEXT7_API_KEY": "{env:CONTEXT7_API_KEY}"
      },
      "enabled": true
    }
  }
}
```

### Environment Variables

```bash
export CONTEXT7_API_KEY="ctx7_..."
```

### Setup Command

```bash
npx ctx7 setup --opencode
```

### MCP Tools

| Tool | Description |
|------|-------------|
| `resolve-library-id` | name → Context7 ID |
| `query-docs` | Get docs by ID + query |

## 7. Out of Scope

- Local MCP server (solo remote)
- Custom Context7 instance
- Analytics/monitoring
- Caching layer

## 8. Dependencies

- OpenCode MCP support
- Context7 account + API key
- GitHub token (para issues)

## 9. Risks

| Risk | Mitigation |
|------|------------|
| Context7 service down | CLI fallback skill |
| API key issues | Document setup clearly |
| Version mismatches | Specify library versions in queries |