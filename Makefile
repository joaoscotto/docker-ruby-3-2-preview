docker:
	@docker build -t web .
	@docker-compose build
	@docker-compose up

start:
	@docker-compose start

stop:
	@docker-compose stop

bash:
	@docker-compose exec web ash

clean:
	@docker-compose down
	@docker system prune --volumes --force
	@rm -rf tmp/* || sudo rm -rf tmp/*

log:
	@docker-compose logs -f --tail=0 web