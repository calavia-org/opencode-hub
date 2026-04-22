---
name: root-cause-analysis
description: Find production issue cause in distributed systems and containerized environments.
---

# Root Cause Analysis Skill

Investigate issues in containerized, distributed environments.

## Steps

1. **Reproduce** - Can you reproduce locally or in dev?
2. **Check logs** - Application, container, orchestrator logs
3. **Inspect resources** - CPU, memory, network, disk
4. **Check deployment** - Recent changes, rollbacks
5. **Network debug** - Service connectivity, DNS
6. **Rank hypotheses** - Most likely causes first
7. **Validate** - Smallest test to confirm
8. **Rollback plan** - Document if needed

## Container Debugging

```bash
# Pod status
kubectl get pods -n namespace
kubectl describe pod <pod>

# Logs
kubectl logs <pod> --previous -n namespace
kubectl logs <pod> -c <container> -n namespace

# Execute in pod
kubectl exec -it <pod> -n namespace -- /bin/sh

# Network debugging
kubectl run network-debug --image=busybox --rm -it -- sh
```

## Common Causes

- OOMKilled (memory limits)
- Liveness probe failures
- Network timeouts
- Dependency failures
- Config map/secrets changes
- Resource exhaustion