FROM ubuntu as base-latest

RUN apt-get update 

#1 - Install basic dependencies
RUN apt-get install -y curl wget zsh git sudo acl docker.io

RUN curl -L "https://github.com/docker/compose/releases/download/v2.14.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
RUN chmod +x /usr/local/bin/docker-compose

RUN useradd -m -G sudo,docker -p $(openssl passwd -1 dev) dev
#RUN setfacl -m "g:docker:rw" /var/run/docker.sock

#2.1 - Install lunavim dependencies (as root)
#https://www.lunarvim.org/docs/installation#prerequisites
RUN wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.deb
RUN apt-get install -y ./nvim-linux64.deb make nodejs cargo g++
RUN wget https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh
RUN chown dev:dev install.sh

#2.2 nerdfonts dependencies (as root)
RUN apt-get install -y fontconfig

#Switching to user dev.
USER dev

#3.1 - Install lunavim (related with step #2.1)
ENV PATH="$PATH:/home/dev/.local/bin"
RUN /bin/bash ./install.sh
COPY config.lua /home/dev/.config/lvim/config.lua
CMD lvim +LiveUpdate +q

#4 - Zsh config (related with #1)
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
RUN sed -i 's/robbyrussell/bira/g' ~/.zshrc

ENTRYPOINT zsh
WORKDIR /app

# ===================
# ======= PHP =======
# ===================
FROM base-latest as base-php

USER root

#1 - Configura php timezone
ENV TZ=Europe/Berlin
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

#2 - Install dependencies
RUN apt-get install -y tzdata php8.1

#3 - Install composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
	&& php -r "if (hash_file('sha384', 'composer-setup.php') === '55ce33d7678c5a611085589f1f3ddf8b3c52d662cd01d4ba75c0ee0459970c2200a51f492d557530c71c15d8dba01eae') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
	&& php composer-setup.php \
	&& php -r "unlink('composer-setup.php');" \
	&& mv composer.phar /usr/local/bin/composer

#4 - Install phpactor [https://phpactor.readthedocs.io/en/master/usage/standalone.html]
RUN apt-get install -y php-curl php-dom php-zip

USER dev

RUN cd ~ \
	&& git clone https://github.com/phpactor/phpactor.git \
	&& cd phpactor \
	&& composer install \
	&& ln -s ~/phpactor/bin/phpactor ~/.local/bin/phpactor \
	&& phpactor status


