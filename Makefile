DATA_PATH := $(HOME)/data

run:
	@echo "using DATA_PATH: $(DATA_PATH)"
	@sudo mkdir -p $(DATA_PATH)/db $(DATA_PATH)/web
	@sudo chmod 700 $(DATA_PATH)/db
	@sudo chmod +x $(DATA_PATH)/web
	@docker compose -f ./srcs/docker-compose.yml up -d --build || echo "Docker failed to start"


kill-mariadb:
	@echo "Killing all MariaDB processes..."
	@pkill -f mysql || echo "No MariaDB processes found."

clean:
	docker compose -f srcs/docker-compose.yml down -v --rmi all
	sudo rm -rf /home/agnes/data/db /home/agnes/data/web

start:
	@docker compose -f ./srcs/docker-compose.yml start
status:
	@docker compose -f ./srcs/docker-compose.yml ps
logs:
	@docker compose -f ./srcs/docker-compose.yml logs -f
stop:
	@docker compose -f ./srcs/docker-compose.yml stop
	@pkill -f mysql || true
down:
	@docker compose -f ./srcs/docker-compose.yml down -v --remove-orphans
	@docker prune -f

re: clean run
