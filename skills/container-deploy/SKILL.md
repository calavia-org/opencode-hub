---
name: container-deploy
description: Docker, Kubernetes, Helm, and Portainer deployment configurations.
---

# Container Deploy Skill

Create and review containerized deployments.

## Docker

### Multi-stage Dockerfile

```dockerfile
# Build stage
FROM golang:1.23-alpine AS builder
WORKDIR /app
COPY . .
RUN go build -o binary .

# Runtime stage
FROM alpine:3.19
COPY --from=builder /app/binary /binary
COPY --from=builder /app/config /config
EXPOSE 8080
ENTRYPOINT ["/binary"]
```

### Healthchecks

```dockerfile
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD wget --no-verbose --tries=1 --spider http://localhost:8080/health || exit 1
```

## Docker Compose

### Basic Service

```yaml
services:
  app:
    build: .
    ports:
      - "8080:8080"
    environment:
      - ENV=${ENV}
    healthcheck:
      test: ["CMD", "wget", "--no-verbose", "--tries=1", "--spider", "http://localhost:8080/health"]
      interval: 30s
      timeout: 3s
      retries: 3
    restart: unless-stopped
    volumes:
      - data:/data
    depends_on:
      db:
        condition: service_healthy

  db:
    image: postgres:16-alpine
    environment:
      POSTGRES_DB: app
      POSTGRES_USER: ${DB_USER}
      POSTGRES_PASSWORD: ${DB_PASSWORD}
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U ${DB_USER} -d ${DB_DB}"]
      interval: 10s
      timeout: 5s
      retries: 5
    volumes:
      - db_data:/var/lib/postgresql/data
    restart: unless-stopped
```

## Kubernetes (Helm)

### Chart Structure

```
helm/
├── Chart.yaml
├── values.yaml
└── templates/
    ├── deployment.yaml
    ├── service.yaml
    ├── ingress.yaml
    └── configmap.yaml
```

### values.yaml

```yaml
image:
  repository: registry/app
  tag: latest
  pullPolicy: IfNotPresent

replicaCount: 2

service:
  type: ClusterIP
  port: 8080

ingress:
  enabled: true
  className: nginx
  annotations:
    cert-manager.io/cluster-issuer: letsencrypt
  hosts:
    - host: app.example.com
      paths:
        - path: /
          pathType: Prefix
  tls:
    - secretName: app-tls
      hosts:
        - app.example.com

resources:
  limits:
    memory: 512Mi
    cpu: 500m
  requests:
    memory: 256Mi
    cpu: 100m

livenessProbe:
  httpGet:
    path: /health
    port: 8080
  initialDelaySeconds: 10
  periodSeconds: 30

readinessProbe:
  httpGet:
    path: /ready
    port: 8080
  initialDelaySeconds: 5
  periodSeconds: 10

autoscaling:
  enabled: true
  minReplicas: 2
  maxReplicas: 10
  targetCPUUtilizationPercentage: 70
```

## Focus Areas

- Health/readiness probes
- Resource limits
- Secret management
- Persistent volumes
- Rolling updates
- Rollback procedures