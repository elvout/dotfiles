# AGENTS.md

## Communication

- Be concise.
- Give direct answers. Avoid unnecessary background, long explanations, and repeated caveats.
- Do not restate visible user-provided code, file contents, IDE selection, command output, or already-established context unless it is necessary to explain a decision.
- When a request is broad or ambiguous, ask pointed clarifying questions instead of covering every possibility.
- Omit invalid answers and options instead of presenting them and explaining why they do not make sense.
- When asked for items satisfying a condition, do not enumerate cases that fail the condition unless they are necessary to explain the answer.

## Code Style

- Avoid single-use helper functions for simple expressions, constants, or thin wrappers. Inline them unless a dedicated function materially improves readability or reduces duplication.
- Avoid overly defensive checks. Prefer reasonable assumptions, but note where validation may be necessary.
- Preserve existing project patterns over introducing new abstractions.
- Python: Use top-level imports.
- Python: Use type annotations.

## Validation

- After code changes, run only lightweight relevant checks (syntax, style, grammar, etc.). Report what was run.
- If a check fails because of missing dependencies or environment setup, report the blocker instead of working around it silently.

## Environment

- Assume Linux unless told otherwise.
- Python: Check for a relevant `.venv` first. If missing, report it. Use `.venv` for Python version, installed packages, syntax checks, and tool calls.
- ROS 2: Assume Jazzy.
