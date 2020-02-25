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
# Composer feature
###
composer_install:
	${DOCKER_COMPOSE} exec -u 0 ${DRUPAL_CONTAINER} bash -c "bash /script/main.sh install_dev_dependancies"

composer_install_nodev:
	${DOCKER_COMPOSE} exec -u 0 ${DRUPAL_CONTAINER} bash -c "bash /script/main.sh install_prod_dependancies"

###
# Drupal feature
###

install_dev:
	${DOCKER_COMPOSE} exec -u root ${DRUPAL_CONTAINER} bash -c "bash /script/main.sh install_site_dev"

###
# Interactive container command
###
ifeq (interactive,$(firstword $(MAKECMDGOALS)))
  CONSOLE_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  $(eval $(CONSOLE_ARGS):;@:)
endif
interactive:
	${DOCKER_COMPOSE} exec ${CONSOLE_ARGS} bash
