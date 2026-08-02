---
paths:
  - "**/*.{ts,tsx}"
---

# TypeScript / React

Lens: modern react.dev + "make impossible states unrepresentable." Clarity over cleverness.
Match the repo's React/TS version and existing idioms.

- Strict TS. No `any`, narrow from `unknown`, or use `never`. `as`/`!` only at real boundaries,
  and make them explicit.
- `interface` for object/prop shapes, `type` for unions and aliases.
- Model nullability explicitly (`string | null`) and handle it, optional chaining, `??`.
- Make illegal states unrepresentable: discriminated unions over scattered optional fields/booleans.
- Components: arrow functions, props destructured inline from a typed interface. No `React.FC`.
- Prefer derived state (compute in render or `useMemo`) over syncing with `useEffect`, effects
  are an escape hatch, not the default tool.
- Custom hooks are an API boundary: one concern, typed input/output, return a named object.
- Honest, complete hook dependency arrays, never silence `exhaustive-deps`.
- Type event handlers and refs with React's own types; don't hand-roll them.
- Prettier/ESLint are truth, match them, don't fight them.
- Push back on non-idiomatic patterns even when the file already does them.
