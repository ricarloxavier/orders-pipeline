# Coding and Code Change Policy

Use this policy for every coding task: implement the smallest safe change that fully satisfies the request. "Small" means fewer moving parts, less new code, fewer dependencies, and less maintenance. It does not mean cutting required safeguards.

The README's "Deferred deliberately" lists deliberate decisions and its not a backlog. Don't implement those unless asked to.

## Decision ladder

Before writing code, stop at the first option that satisfies the requirement:

1. The change is not needed or is speculative: explain briefly and do not add it.
2. Reuse existing project code, conventions, utilities, types, or dependencies.
3. Use the language standard library.
4. Use a native platform or browser capability.
5. Use an installed dependency directly.
6. Write the minimum custom code needed.

Inspect the repository before adding a helper, abstraction, dependency, configuration file, or new architecture. Prefer a focused edit to existing code over a new layer or wrapper.

## Safety floor

Never trade away input validation at trust boundaries, authentication or authorization, data-loss protections, error handling that users rely on, accessibility, privacy, or required tests just to reduce code.

## Modes

Default to **full** mode. Honor a user instruction such as `minimal path: lite`, `minimal path: full`, or `minimal path: ultra` for the current request.

- **lite**: favor simple, idiomatic solutions without an extended alternatives analysis.
- **full**: apply the decision ladder and mention the chosen simpler path when it materially affects the implementation.
- **ultra**: challenge each requested addition, remove unnecessary scope, and offer the smallest viable alternative before coding.

## Ask before touching

- `seeds/sample_orders.csv` is the supplied data source, and the README's acceptance numbers are
  derived from it. Changing one without the other makes the submission inconsistent.
- `infra/` is an undeployed blueprint. Check it with `terraform init -backend=false`,
  `terraform fmt -check`, and `terraform validate`. Never `terraform apply`, and don't add
  resources that would bill.
- The checked-in Postgres password is a local-only default. Never add a real credential.

## Reviews and explanations

When asked to review for bloat, identify removable code, duplicate helpers, unnecessary dependencies, needless abstractions, and native or standard-library replacements. Do not recommend simplifications that violate the Safety floor.

For non-obvious implementation choices, state in one or two sentences which rung of the decision ladder was selected and why an earlier rung did not fit. Keep ordinary responses concise.
