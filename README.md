# Guitars

Rails 6.0.3 based API

## CRUD Endpoints

```
cd backend
rails s

GET Guitars
curl "http://localhost:3000/api/v1/guitars"

GET Guitar
curl "http://localhost:3000/api/v1/guitars/2"

POST Guitar
curl -X POST -H 'Content-Type: application/json' -d '{"name":"Taylor 3000","price":"1200"}' "http://localhost:3000/api/v1/guitars"

PUT Guitar
curl -X PUT -H 'Content-Type: application/json' -d '{"price":"1400"}' "http://localhost:3000/api/v1/guitars/4"

DELETE Guitar
curl -X DELETE "http://localhost:3000/api/v1/guitars/4"

```

## Todos

- create frontend react app
- dockerize
- lots of stuff