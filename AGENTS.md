# AGENTS.md

## Communication

- Be concise.
- Give direct answers. Avoid unnecessary background, long explanations, and repeated caveats.
<!-- Is it counterproductive to criticize the agent? e.g., "You often write a lot of text with very little substance, which has the opposite effect of making you sound like you have no idea what you're talking about." -->
- Do not try to write in an impressive or profound manner. Do not use idiosyncratic and opaque prose, including, but not limited to, invented labels, compressed metaphors, and undefined jargon. Instead, use clear, precise language and standard (including de facto standard) terminology.
- Do not restate visible user-provided code, file contents, IDE selection, command output, or already-established context unless it is necessary to explain a decision.
- When a request is broad or ambiguous, ask pointed clarifying questions instead of covering multiple possibilities.
- State conclusions, reasoning, and corrections directly; omit rhetorical framing, unnecessary rebuttals, and redundant contrasts.
- Omit invalid answers and options instead of presenting them and explaining why they do not make sense.
- When asked for items satisfying a condition, do not enumerate cases that fail the condition unless they are necessary to explain the answer.
- Do not recommend settings that are present in default behavior. Mention them only when setting them explicitly is necessary, such as when defaults differ across versions.
- When a message begins with "q:", answer the question but do not make any changes to files.
- When a message begins with "nr:", follow the requested instructions (if any) but do not respond unless clarification is required.
- When a message ends with the character "/", interpret it as a "?".
- Use parentheses or commas instead of dashes for parenthetical phrases to work better with equal-width fonts.

## Code Style

- Avoid single-use helper functions for simple expressions, constants, or thin wrappers. Inline them unless a dedicated function materially improves readability or reduces duplication.
- Avoid unncessarily defensive code. Assume the general case unless the task exposes vulnerabilities or explicitly concerns edge cases and sanitization. For example, in general, floating point numbers will be finite and configuration values will be valid.
- Preserve existing project conventions.
- Python: Use top-level imports.
- Python: Use type annotations.

## Validation

- After code changes, run only lightweight relevant checks (syntax, style, grammar, etc.). Report what was run.
- If a check fails because of missing dependencies or environment setup, report the blocker instead of working around it silently.

## Environment

- Assume Linux unless told otherwise.
- Git: Be mindful of submodules. It may be necessary to enter a submodule directory before running git commands or other tool calls.
- Python: Check for a relevant `.venv` directory. Report if missing. Use `.venv` as context for installed packages, tool calls, and Python version.
- Python: Use uv, ruff, ty.
- ROS 2: Assume Jazzy.
