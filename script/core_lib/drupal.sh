#!/usr/bin/env bash

export PATH=$PATH:/root/.composer/vendor/bin

function install_site_dev() {
  cd ${DRUPAL_DOCROOT}
  chmod +w ${DRUPAL_DOCROOT}/sites/default
  chmod +w ${DRUPAL_DOCROOT}/sites/default/*
  drush site:install --existing-config
}
