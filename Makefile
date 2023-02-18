dev-docker = docker compose -f docker-compose.yml -f docker-compose.local.yml
dev:
	@$(dev-docker) down
	@$(dev-docker) up -d --build
.PHONY: dev
