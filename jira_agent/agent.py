
import os
import sys


def require_secret(name: str) -> str:
    value = os.getenv(name)
    if not value:
        raise RuntimeError(f"Required configuration is missing: {name}")
    return value


def main():
    issue_key = os.getenv("JIRA_ISSUE_KEY", "").strip()

    if not issue_key:
        raise RuntimeError("JIRA_ISSUE_KEY is required")

    jira_base_url = require_secret("JIRA_BASE_URL").rstrip("/")
    jira_email = require_secret("JIRA_EMAIL")
    jira_api_token = require_secret("JIRA_API_TOKEN")
    openai_api_key = require_secret("OPENAI_API_KEY")
    github_token = require_secret("GH_TOKEN")
    repository = require_secret("GITHUB_REPOSITORY")

    print(f"Agent configuration loaded for Jira issue: {issue_key}")
    print(f"Jira URL: {jira_base_url}")
    print(f"GitHub repository: {repository}")

    # Next step:
    # 1. Fetch Jira issue and description.
    # 2. Ask the AI to propose Salesforce metadata changes.
    # 3. Validate changes before writing files.
    # 4. Create a feature branch, commit and push.
    # 5. Create a pull request.

    print("Setup check passed. Implementation is not enabled yet.")


if __name__ == "__main__":
    try:
        main()
    except Exception as exc:
        print(f"Agent stopped: {exc}", file=sys.stderr)
        sys.exit(1)
