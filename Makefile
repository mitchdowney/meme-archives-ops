.PHONY: local_up_db
local_up_db:
	docker compose -f ./docker/docker-compose-local.yml up meme_archives_db -d

.PHONY: local_up_all
local_up_all:
	docker compose -f ./docker/docker-compose-local.yml up -d

.PHONY: local_down_all
local_down_all:
	docker compose -f ./docker/docker-compose-local.yml down

.PHONY: prod_up_db
prod_up_db:
	docker compose -f ~/meme-archives-ops/docker/docker-compose-prod.yml up meme_archives_db -d

.PHONY: prod_up_all
prod_up_all:
	docker compose -f ~/meme-archives-ops/docker/docker-compose-prod.yml up nginx_proxy -d
	docker compose -f ~/meme-archives-ops/docker/docker-compose-prod.yml up acme_companion -d
	docker compose -f ~/meme-archives-ops/docker/docker-compose-prod.yml up meme_archives_db -d
	docker compose -f ~/meme-archives-ops/docker/docker-compose-prod.yml up meme_archives_api -d
	docker compose -f ~/meme-archives-ops/docker/docker-compose-prod.yml up meme_archives_tg_bot -d
	docker compose -f ~/meme-archives-ops/docker/docker-compose-prod.yml up meme_archives_web -d

.PHONY: prod_down_all
prod_down_all:
	docker compose -f ~/meme-archives-ops/docker/docker-compose-prod.yml down

.PHONY: rebuild_api
rebuild_api:
	docker compose -f ~/meme-archives-ops/docker/docker-compose-prod.yml build --no-cache meme_archives_api
	docker compose -f ~/meme-archives-ops/docker/docker-compose-prod.yml up -d meme_archives_api

.PHONY: rebuild_tg_bot
rebuild_tg_bot:
	docker compose -f ~/meme-archives-ops/docker/docker-compose-prod.yml build --no-cache meme_archives_tg_bot
	docker compose -f ~/meme-archives-ops/docker/docker-compose-prod.yml up -d meme_archives_tg_bot

