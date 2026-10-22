---
name: register-slack-user
description: Register a GitHub username <> Slack user ID mapping for Slack notifications in sonio-ai/sonio-core and sonio-ai/sonio-actions, through a Linear ticket and one PR per repository
argument-hint: <SLACK_USER_ID> <GITHUB_USERNAME>
---

## Inputs

- The Slack user ID, such as `U086WND2DCK`
- The GitHub username, such as `aseure`
- Take them from the arguments; ask me for any that is missing
- Stop if the Slack user ID does not match `^U[A-Z0-9]{8,}$`, or if `gh api users/<GITHUB_USERNAME>` finds no such GitHub user

## Linear ticket

- Create the ticket with the Linear MCP:
  - Team: `Platform`
  - Assignee: `me`
  - Title: `Register <GITHUB_USERNAME> for Slack notifications`
  - Description: one sentence saying which GitHub username gets mapped to which Slack user ID, in sonio-core and sonio-actions
- Keep its identifier, such as `PF-42`, as `<LINEAR_TICKET_ID>`

## Repositories

Do the following for `sonio-ai/sonio-core`, then for `sonio-ai/sonio-actions`:

- Clone the repository into a fresh directory under `$TMPDIR` with `gh repo clone`, and create the branch `aseure/<LINEAR_TICKET_ID>` from the default branch
- Locate every constant mapping GitHub usernames to Slack user IDs, by grepping for Slack user IDs (`U0[A-Z0-9]{8,}`) in Bash and Python files:
  - In sonio-core, only look under `.github/workflows/`
  - In sonio-actions, look in the whole repository
  - Expect at least `.github/workflows/scripts/git-slack-users.sh` in sonio-core, `git-slack-users.sh` and `send-slack-message/constants.py` in sonio-actions; stop and tell me if you find none of them
- In each mapping:
  - If the GitHub username or the Slack user ID is already there, leave the mapping untouched and tell me about it
  - Otherwise add the new entry with exactly the same formatting as its neighbours
  - If the user entries are sorted, insert it at its sorted position; otherwise append it after the last user entry
  - Keep it among the user entries, never in another section such as Slack usergroups (`S...` IDs)
- Check that each modified file still parses: `bash -n` for Bash, `python -c "import ast, sys; ast.parse(open(sys.argv[1]).read())"` for Python
- Show me the diff
- Skip the rest of this section if nothing changed in the repository
- Commit with the message `Register <GITHUB_USERNAME> for Slack notifications`, then push the branch
- Open the PR with `gh pr create`:
  - Title: `[<LINEAR_TICKET_ID>] Register <GITHUB_USERNAME> for Slack notifications`
  - Body: the mapping added, the files modified, and the Linear ticket ID

## Report

- Give me the Linear ticket ID and the two PR links
- Mention every repository or mapping you skipped, and why
