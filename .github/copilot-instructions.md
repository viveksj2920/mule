# Copilot Instructions

This repository hosts a MuleSoft API with HIPAA-sensitive integration context.

## Required Practices

- Never commit or expose credentials, tokens, or PHI.
- Do not log payload bodies or PHI fields.
- Prefer metadata-only audit logging.
- Reuse shared/common logging flows where available.
- Keep CI checks green for build and test before merge.

## Build and Test

- Build: `mvn -B -ntp clean package -DskipMunitTests=true`
- Test: `mvn -B -ntp test -DskipMunitTests=true`

## Branch and PR

- Base branch: `develop`
- PR base branch: `develop`
- Use `feature/` branches for changes.
