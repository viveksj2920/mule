# Agent Guidance

This repository hosts the MuleSoft GPD Experience API. Follow these rules for any automated or assisted change.

## Build, Test, Run

- Build: `mvn -B -ntp clean package -DskipMunitTests=true`
- Test: `mvn -B -ntp test -DskipMunitTests=true`
- Local run: use the existing Anypoint Studio/Mule runtime workflow for this API.

## Branch and PR Rules

- Base branch: `develop`
- PR target branch: `develop`
- Feature branch prefix: `feature/`
- Do not push directly to long-lived branches.

## Change Boundaries

- Allowed without extra approval: Mule flow changes, DataWeave updates, test updates, docs, and CI workflows.
- Ask-first required: security/auth changes, logging schema changes, deployment behavior changes, and dependency upgrades.
- Forbidden: committing live credentials, secrets, tokens, or PHI-containing sample data.

## Logging and PHI Guardrails

- Never log payload bodies or PHI fields.
- Prefer metadata-only audit logging (event, correlationId, path, method, status, latency).
- Keep masking/redaction behavior enabled in environment config.

## Definition of Done

- Build passes in CI.
- Test command runs in CI.
- Security scan workflow runs on PR.
- CODEOWNERS routes review to accountable owners.
