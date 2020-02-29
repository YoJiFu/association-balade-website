#!/usr/bin/env bash

export PATH=$PATH:/root/.composer/vendor/bin

function update_admin_password() {
  drush user:password admin "admin"
}

function install_site_dev() {
  echo "WIP"
  # cd ${DRUPAL_DOCROOT}
  # chmod +w ${DRUPAL_DOCROOT}/sites/default
  # chmod +w ${DRUPAL_DOCROOT}/sites/default/*
  # drush site:install standard
  # update_admin_password
  # sed -i '/config_sync_directory/d' ${DRUPAL_DOCROOT}/sites/default/settings.php
  # echo "\$settings['config_sync_directory'] = '/config/yml/sync/';" >> ${DRUPAL_DOCROOT}/sites/default/settings.php
  # drush cim -y
}

function uninstall_site() {
  drush sql:drop -y
  rm -rfv ${DRUPAL_DOCROOT}/sites/default/settings.php
}
