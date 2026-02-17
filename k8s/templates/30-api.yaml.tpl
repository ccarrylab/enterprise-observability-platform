apiVersion: apps/v1
kind: Deployment
metadata:
  name: observability-api
  namespace: default
spec:
  replicas: 2
  selector:
    matchLabels: { app: observability-api }
  template:
    metadata:
      labels: { app: observability-api }
    spec:
      containers:
        - name: api
          image: ${API_IMAGE}
          ports:
            - { containerPort: 8080 }
          env:
            - name: OTEL_EXPORTER_OTLP_ENDPOINT
              value: http://otel-collector.observability.svc.cluster.local:4318
            - name: OTEL_SERVICE_NAME
              value: observability-api
---
apiVersion: v1
kind: Service
metadata:
  name: observability-api
  namespace: default
spec:
  selector: { app: observability-api }
  ports:
    - { port: 80, targetPort: 8080 }
  type: ClusterIP
