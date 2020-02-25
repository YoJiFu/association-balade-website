DOCKER_COMPOSE="docker-compose"
DRUPAL_CONTAINER="drupal"

###
# Docker command
###
start:
	${DOCKER_COMPOSE} up -d

stop:
	${DOCKER_COMPOSE} stop

restart:
	${DOCKER_COMPOSE} stop && ${DOCKER_COMPOSE} start

purge:
	${DOCKER_COMPOSE} down

###
# Feature
###


###
# Interactive container command
###
ifeq (interactive,$(firstword $(MAKECMDGOALS)))
  CONSOLE_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  $(eval $(CONSOLE_ARGS):;@:)
endif
interactive:
	${DOCKER_COMPOSE} exec ${CONSOLE_ARGS} bash
