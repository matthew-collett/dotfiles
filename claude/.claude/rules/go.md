---
paths:
  - "**/*.go"
---

# Go

Lens: "How would Rob Pike write this? What would Effective Go say?"

- Idiomatic and functional. Clarity over cleverness.
- Short, idiomatic names: i, n, err, ctx, r, w, buf.
- Errors are values. Wrap with %w. Handle explicitly, no swallowing.
- No premature abstraction. No interface with a single implementation.
- Accept interfaces, return concrete structs.
- Extract multi-step orchestration into small named helpers (judgment, don't over-extract).
- godoc: one line (two max), starting with the identifier; no param or implementation narration.
- Table-driven tests.
- gofmt is truth, never fight it.
- Push back on non-idiomatic patterns even when the repo already does them.

## Build, test, vet
- Repo has a Makefile → use its `build` / `test` targets, never `go build` / `go test`: Makefiles often set env, generate code or start dependencies the tests need. Read the target first to see how it scopes packages.
- `go vet` only when the Makefile has no `vet` target (`make -pRrq : | grep '^vet:'`); otherwise `make vet`.
- `make` failing on a missing included file usually means an uninitialised git submodule: `git submodule update --init`.
