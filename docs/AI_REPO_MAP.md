# AI_REPO_MAP.md

Compact navigation map for Claude Code. Use this before opening source files.

## Entry Points

- `README.md` - project overview and documentation links.
- `Makefile` - common checks, Docker lifecycle, protobuf generation, trace tests.
- `docker-compose.yml` - main service graph, ports, dependencies, env.
- `docker-compose.minimal.yml` - smaller local demo mode.
- `docker-compose-tests.yml` - frontend and trace-based test runners.
- `pb/` - shared protobuf definitions.
- `test/tracetesting/` - service-level trace validation.

## Service Map

| Concern | Start Here | Stack Signal | Tests |
|---|---|---|---|
| Accounting | `src/accounting/` | .NET, `Accounting.csproj` | none obvious |
| Ads | `src/ad/` | Java/Gradle, `build.gradle` | `test/tracetesting/ad/` |
| Cart | `src/cart/` | service source plus tests | `test/tracetesting/cart/` |
| Checkout | `src/checkout/` | Go, `go.mod` | `test/tracetesting/checkout/` |
| Currency | `src/currency/` | service source, proto/build output | `test/tracetesting/currency/` |
| Email | `src/email/` | service source and templates | `test/tracetesting/email/` |
| Fraud Detection | `src/fraud-detection/` | Java/Kotlin Gradle | none obvious |
| Frontend | `src/frontend/` | Node/Next.js, `package.json` | `test/tracetesting/frontend/`, `src/frontend/cypress/` |
| Frontend Proxy | `src/frontend-proxy/` | proxy config | compose-level checks |
| Image Provider | `src/image-provider/` | static image service | compose-level checks |
| Load Generator | `src/load-generator/` | Python, `requirements.txt` | compose-level checks |
| Payment | `src/payment/` | Node, `package.json` | `test/tracetesting/payment/` |
| Product Catalog | `src/product-catalog/` | Go, `go.mod` | `test/tracetesting/product-catalog/` |
| Product Reviews | `src/product-reviews/` | Python, `requirements.txt` | `test/tracetesting/product-reviews/` |
| Quote | `src/quote/` | PHP-style app layout | compose-level checks |
| Recommendation | `src/recommendation/` | Python, `requirements.txt` | `test/tracetesting/recommendation/` |
| Shipping | `src/shipping/` | Rust, `Cargo.toml` | `test/tracetesting/shipping/` |
| Feature Flags | `src/flagd/`, `src/flagd-ui/` | flagd config, Elixir UI | compose-level checks |
| LLM | `src/llm/` | Python, `requirements.txt` | compose-level checks |
| Mobile App | `src/react-native-app/` | React Native, `package.json` | local app checks |
| Observability | `src/otel-collector/`, `src/grafana/`, `src/prometheus/`, `src/jaeger/`, `src/opensearch/` | config-heavy | compose-level checks |
| Data Stores | `src/postgresql/`, compose `astronomy-db`, `valkey-cart`, `kafka` | config/data services | compose-level checks |
| Telemetry Docs | `src/telemetry-docs/`, `telemetry-schema/` | generated docs/schema | docs checks |

## Task Routing

- UI/page work: start in `src/frontend/pages/`, then `components/`, `services/`, `gateways/`.
- Frontend API or gRPC calls: inspect `src/frontend/gateways/`, `src/frontend/services/`, and relevant `genproto/` only if needed.
- Service behavior: inspect `src/<service>/` manifest, then nearest handler/main files.
- Inter-service wiring: inspect the service block in `docker-compose.yml`.
- Trace expectations: inspect `test/tracetesting/<service>/`.
- Protobuf changes: inspect `pb/`, then generated outputs only after generation.
- Observability config: inspect `src/otel-collector/`, `otel-config.yml`, and the relevant backend config.
- Feature flag behavior: inspect `src/flagd/` first, then the caller service.

## Verification Menu

- Repo state: `git status --short`
- Docs/lint baseline: `make markdownlint`, `make yamllint`
- License check: `make checklicense`
- Focused trace tests: `make run-tracetesting SERVICES_TO_TEST=<service>`
- Full test flow: `make run-tests`
- Protobuf regeneration: `make generate-protobuf` or `make docker-generate-protobuf`

Prefer the narrowest relevant check. Docker-based commands may be slow and require local Docker.

## Avoid By Default

- Dependency folders: `node_modules`, `.gradle`, `.venv`, `vendor`, `Pods`
- Build outputs: `build`, `dist`, `_build`, `.expo`
- Generated protobuf outputs: `genproto`, `*_pb2.py`, `*_pb2_grpc.py`, `src/frontend/protos/demo.ts`
- Large service configs unless the task is about deployment or wiring
