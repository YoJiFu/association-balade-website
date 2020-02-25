FROM drupal:8.8.2-apache

# Install composer-cli
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install drush-cli
RUN composer global require drush/drush
RUN echo 'export PATH=$PATH:/root/.composer/vendor/bin' >> /root/.bashrc

# Install drupal-cli
RUN curl https://drupalconsole.com/installer -L -o drupal.phar &&\
    mv drupal.phar /usr/local/bin/drupal &&\
    chmod +x /usr/local/bin/drupal

# Install other required tools
RUN apt-get update && \
    apt-get install -y git
