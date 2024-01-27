.PHONY: up_db
up_db:
	docker-compose -f docker/docker-compose.yml up paintsol_db -d

.PHONY: up_all
up_all:
	docker-compose -f docker/docker-compose.yml up -d

.PHONY: down_all
down_all:
	docker-compose -f docker/docker-compose.yml down
