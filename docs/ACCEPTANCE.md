# Synthetic acceptance matrix

Use only non-secret, random synthetic markers. Never ingest real user data merely to prove a deployment.

| Gate | Procedure | Passing evidence | Failure means |
|---|---|---|---|
| Health | GET `/v3/health` | successful response | process unavailable or proxy misconfigured |
| Document admission | add synthetic document | typed document identity + queued/accepted state | write path broken |
| Terminal state | poll the document resource | terminal `done` (not merely admitted) | extraction/index pipeline unproven |
| Scoped document retrieval | search exact marker in expected container | expected chunk/document result | scope or indexing mismatch |
| Profile/memory retrieval | search/profile expected extracted fact | typed v4 memory/profile result when extraction is enabled | memory plane unproven |
| Direct memory | create exact synthetic v4 memory | real v4 memory ID | direct-memory path unavailable |
| Soft forget | soft-forget that **memory ID** | hidden from default memory retrieval | delete/forget semantics broken |
| Type safety | attempt tool-level document→forget request | rejected locally before API call | adapter has dangerous ID confusion |
| Restart | restart service and repeat scoped search | same expected behavior | persistence/lifecycle issue |
| Restore | restore isolated backup and repeat checks | same expected behavior | backup/restore not trustworthy |
| Privacy | inspect test fixtures/log excerpts | no credentials/private corpus | governance failure |

## Lifecycle rule

A v3 document ID and a v4 memory ID are different resource identities. A document can produce extracted memory, profile, and search artifacts. Never call memory soft forget with a document ID. Document retention/deletion must use the upstream document lifecycle only after the organization has explicitly approved that destructive action.

## Report format

Record: server/CLI pins, container tag, synthetic marker hash (not raw marker if public), timestamps, endpoint class, status transitions, aggregate latency, and outcome. Keep raw responses and any generated server token private.
