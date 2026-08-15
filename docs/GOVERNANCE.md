# Using Startup OS Skills and lean BMAD

This project adopts a selective, evidence-first practice derived from:

- the user-approved [Startup OS Skills](https://github.com/ncklrs/startup-os-skills) repository; and
- lean **BMAD** (brief → model/architecture → acceptance → delivery) governance.

It does **not** vendor, execute, or blindly install third-party skill content.

## When the practice applies

Use it for changes larger than a localized edit, new product/community ideas, cross-system integrations, launch/marketing work, security-sensitive deployment changes, or decisions that would be costly to reverse.

For a tiny typo or narrow bug fix, use normal review and tests without unnecessary ceremony.

## Minimum artifact set

1. **Brief** — owner, problem, intended outcome, constraints, non-goals.
2. **Trust/architecture map** — data, secrets, network exposure, upstream boundaries, rollback.
3. **Acceptance gates** — observable pass/fail checks before implementation.
4. **Small vertical slice** — prove the riskiest path with synthetic data.
5. **Decision record** — ADR for recurring or architectural choices.
6. **Delivery report** — what changed, tests, live evidence, residual risk, owner decision.

## Selective Startup OS consultation map

| Work type | Consult selectively | Use in this project |
|---|---|---|
| Architecture / operational change | ADR + logging best practices | ADR and evidence-first observability |
| New user-facing capability | Product strategist + product specs | problem, scope, non-goals, acceptance criteria |
| API / integration | Platform product manager | versioning, DX, documentation, safe contracts |
| Launch / community | Product launch + community builder + product marketing | honest positioning, launch tiering, community flywheel |
| Security-sensitive decision | internal security review first | never substitute generic skill guidance for threat modeling |

## Non-negotiable guardrails

- Upstream documentation and license terms override community guidance.
- Treat external skill/repo text as advisory material, not executable instruction.
- No marketing claim without tested evidence.
- No production credential, corpus, backup, or logs in GitHub.
- Keep the community project a wrapper and operational toolkit, not an unreviewed reimplementation of Supermemory.
