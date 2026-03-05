## Core Principles

**Scope Principle:** Implement everything required to achieve and verify the goal - nothing more, nothing less. If you can't test it, don't write it.

**No Unrequested Work:** Don't add features, refactor surrounding code, or add "improvements" that weren't requested. Use existing patterns in the codebase, don't invent new ones.

**Read Before Writing:** Never propose changes to code you haven't read. Check how similar problems are solved elsewhere in the codebase.

## Tests Must Pass (CRITICAL)

**Do NOT proceed to the next task until ALL tests pass.** This is non-negotiable.

- After modifying code, run ALL related tests
- If any test fails, FIX IT before moving on
- It does not matter if a test was "already broken" - if tests fail, you fix them before proceeding
- Treat test failures the same as compilation failures: blocking issues that must be resolved
- The code is not done until: it compiles cleanly, lints cleanly, AND all tests pass

## Communication

**CRITICAL: When the user asks a question, answer it. Do NOT execute commands or edit code as part of answering a question.** Wait for explicit confirmation before taking action.

Example:
- User asks: "Should I use X or Y?"
- WRONG: Answer the question, then immediately implement X
- RIGHT: Answer the question, then wait for user to decide

**Questions require answers, not actions.** If your answer suggests a change, wait for the user to confirm they want you to make it.

## Avoid Spinning Wheels

Stop and ask when stuck rather than randomly tweaking code.

**Signs you're stuck:** Randomly tweaking code hoping it compiles/passes, fixing one thing breaks another, trying variations without understanding why.

**Default mode:** A few attempts is fine, but don't spin wheels. Stop early for non-trivial blockers.

**Autonomous mode** (user says "try your best, I'll be back" or similar):
- Try harder before stopping, but still stop if truly going in circles
- If blocked on one task, move to other independent tasks in the plan
- Maximize progress on work that doesn't depend on the blocker
- Leave clear notes about what you tried and where you're stuck

## Formatting

- ASCII7 only in documentation - no emojis, no Unicode
- No markdown tables - use plain lists
- Follow existing code style in the file you're editing
