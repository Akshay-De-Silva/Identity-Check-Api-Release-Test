postgres:
	docker run --name postgresdb -p 5000:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:alpine3.16
createdb:
	docker exec -it postgresdb createdb --username=root --owner=root persons

dropdb:
	docker exec -it postgresdb dropdb persons

migrateup:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5000/persons?sslmode=disable" -verbose up
migratedown:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5000/persons?sslmode=disable" -verbose down
sqlc:
	sqlc generate
test:
	go test -v -cover ./...
.PHONY:  postgres createdb dropdb migrateup migratedown sqlc