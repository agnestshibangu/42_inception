run:
	@sudo mkdir -p /home/agtshiba/data/db /home/agtshiba/data/web
	@sudo chmod 700 /home/agtshiba/data/db
	@sudo chmod 755 /home/agtshiba/data/web
	@docker compose -f ./srcs/docker-compose.yml up -d --build || echo "Docker failed to start"

kill-mariadb:
	@echo "Killing MariaDB container..."
	@docker kill mariadb || echo "MariaDB container not running."

clean:
	@docker compose -f srcs/docker-compose.yml down -v --rmi all
	@sudo rm -rf /home/agtshiba/data/db /home/agtshiba/data/web

start:
	@docker compose -f ./srcs/docker-compose.yml start

status:
	@docker compose -f ./srcs/docker-compose.yml ps

logs:
	@docker compose -f ./srcs/docker-compose.yml logs -f

stop:
	@docker compose -f ./srcs/docker-compose.yml stop
	@docker kill mariadb || true

down:
	@docker compose -f ./srcs/docker-compose.yml down -v --remove-orphans
	@docker system prune -f

re: clean run

