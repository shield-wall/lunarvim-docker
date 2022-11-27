FROM ubuntu

RUN apt-get update 
RUN apt-get install -y curl wget zsh git

RUN useradd -m dev -G sudo -p dev

#lunavim
#https://www.lunarvim.org/docs/installation#prerequisites
RUN wget https://github.com/neovim/neovim/releases/download/v0.8.1/nvim-linux64.deb
RUN apt-get install -y ./nvim-linux64.deb make nodejs cargo

RUN wget https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh
RUN chown dev:dev install.sh

USER dev
ENV PATH="$PATH:/home/dev/.local/bin"
RUN /bin/bash ./install.sh

#Zsh config
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
RUN sed -i 's/robbyrussell/bira/g' ~/.zshrc

ENTRYPOINT zsh
WORKDIR /app
