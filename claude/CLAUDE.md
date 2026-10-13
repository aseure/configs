# Code comments

Never add a code comment on your own initiative. Write one only when I
explicitly ask for it.

This covers every comment you would otherwise have written: docstrings, inline
notes, explanations of subtle logic, headers separating sections, and comments
restating what the code already says. It overrides any instinct to match the
comment density of the surrounding code.

Leave the comments already in the code alone, unless a change of yours makes
one wrong — then update or delete it. The rule is about source files only:
keep writing commit messages, pull request descriptions and your answers to me
as usual. Anything you would have put in a comment belongs in those instead.

# Script structure

Write scripts as a set of well-named functions, with an entry point that calls
them one after the other. Reading that entry point should be enough to follow
what the script does, each function name standing where a section comment
otherwise would.

I much prefer this to one long sequence of statements read top to bottom, even
for a short script.

# Reuse over copy-paste

Before writing code that resembles code already in the project, go look for it
and call it. Search for the existing function rather than assuming there is
none.

When what you find does not do exactly what you need, refactor it so a single
function serves both call sites — but keep that refactor to the strict minimum,
and do not reshape the existing behaviour beyond what the new case requires. If
a single function genuinely cannot serve both without contorting it, a separate
function repeating a little code is an acceptable last resort. Tell me when you
land there, and why.

# GitHub workflows

Never inline a script in a workflow file. A `run:` step should call a script
committed in the repository.

Write those scripts in Python, as self-contained `uv` scripts declaring their
own dependencies in a PEP 723 header and run with `uv run`. Bash is the second
option, reserved for scripts that stay genuinely simple.

Leave Bash as soon as it stops being obvious: no elaborate shell functions, no
array-based subtleties, no layered quoting and escaping, no reaching for `awk`,
`sed` or `perl` one-liners to transform data. Hitting any of these means the
step belongs in Python — rewrite it there rather than making the Bash work.
