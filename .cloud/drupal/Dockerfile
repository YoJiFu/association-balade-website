FROM drupal:8.8.2-apache

# Install composer-cli
RUN apt-get update &&\
    apt-get install wget &&\
    wget https://getcomposer.org/download/1.7.2/composer.phar &&\
    mv composer.phar /usr/local/bin &&\
    chmod 777 /usr/local/bin/composer.phar &&\
    mv /usr/local/bin/composer.phar /usr/local/bin/composer

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
