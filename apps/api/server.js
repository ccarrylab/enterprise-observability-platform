'use strict';

const express = require('express');

const { NodeSDK } = require('@opentelemetry/sdk-node');
const { getNodeAutoInstrumentations } = require('@opentelemetry/auto-instrumentations-node');
const { OTLPTraceExporter } = require('@opentelemetry/exporter-trace-otlp-http');
const { OTLPMetricExporter } = require('@opentelemetry/exporter-metrics-otlp-http');

const otlpEndpoint = process.env.OTEL_EXPORTER_OTLP_ENDPOINT || 'http://otel-collector.observability.svc.cluster.local:4318';

const sdk = new NodeSDK({
  traceExporter: new OTLPTraceExporter({ url: `${otlpEndpoint}/v1/traces` }),
  metricExporter: new OTLPMetricExporter({ url: `${otlpEndpoint}/v1/metrics` }),
  instrumentations: [getNodeAutoInstrumentations()]
});

sdk.start();

const app = express();
app.use(express.json());

app.get('/health', (req, res) => res.json({ ok: true }));
app.get('/work', async (req, res) => {
  const ms = Math.floor(50 + Math.random() * 250);
  await new Promise(r => setTimeout(r, ms));
  res.json({ ok: true, latency_ms: ms });
});

app.listen(8080, () => console.log('observability-api listening on :8080'));
