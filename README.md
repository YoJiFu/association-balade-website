# Association ballade website.

## Basic informations

URL : http://associationballade.org/

## For dev

### Install dev tools

Docker : https://docs.docker.com/install/

Docker-compose : https://docs.docker.com/compose/install/

### Make command

```bash
# Build and start docker container
make build

# Start docker container
make start

# Stop docker container
make stop

# Restart docker container
make restart

# Uninstall site
make uninstall_site

# Interact with container directly
make interactive <container>
# Example :
# make interactive drupal
# make interactive mariadb
```

### Install site
```bash
git clone https://github.com/bzhazreal/association-balade-website.git
make composer_install

# Open browser and type localhost
# Step 1 : Langage => Select english
# Step 2 : Config => Select existing config and type config/sync/ as config folder.
# Validate and continue installation.
```
