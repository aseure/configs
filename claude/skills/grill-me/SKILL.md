---
name: grill-me
description: Grill me with questions on a technical or product subject until it is fully understood, then write a Technical Design document
---

- Start from the subject I give you; if I gave none, ask me for it
- Explore the codebase whenever it can answer a question better than I can, instead of asking me
- Ask me questions until we reach the bottom of the subject:
  - Ask one focused question at a time, building on my previous answers
  - Challenge vague, contradictory or hand-wavy answers; ask for concrete examples, numbers and constraints
  - Probe the why behind the need, the users impacted, edge cases, failure modes, alternatives, trade-offs, migration and rollout
  - Keep going until no section of the document below would rely on a guess
- When you have no open question left, tell me and ask whether I want to add anything before you write the document
- Write the Technical Design document in markdown, with exactly these sections:
    ```
    # <Title>

    ## Overview

    ## Context

    ## Problems we want to solve

    ## Out-of-scope

    ## Proposed design

    ## Implementation details
    ```
- Ask me where to save the document, defaulting to `<kebab-case-title>.md` in the current directory
