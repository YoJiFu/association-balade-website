#!/usr/bin/env bash

function install_dev_dependancies() {
  cd ${DRUPAL_DOCROOT} && composer install 
}

function install_prod_dependancies() {
  cd ${DRUPAL_DOCROOT} && composer install --no-dev
}
