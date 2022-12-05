FROM ubuntu

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
