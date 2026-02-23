# financial-app-cards

Cards microservice — credit/debit card management, statements, and expiration tracking.

## Port: 8083

## Database Schema: `cards`

## Endpoints
```
GET    /api/v1/cards
POST   /api/v1/cards
PUT    /api/v1/cards/{id}
DELETE /api/v1/cards/{id}
GET    /api/v1/cards/{id}/statements
POST   /api/v1/cards/{id}/statements
```

## Kafka — Publishes
- `card.expiring`

## Environment Variables
See `.env.example`.

## Local Development

```bash
cd ../financial-app-parent && mvn install -N
cd ../financial-app-cards
cp .env.example .env
mvn spring-boot:run
```

## Swagger
`http://localhost:8083/swagger-ui.html`
