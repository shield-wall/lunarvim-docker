FROM ubuntu

RUN apt-get update 

#1 - Install basic dependencies
RUN apt-get install -y curl wget zsh git

RUN useradd -m dev -G sudo -p dev

#2 - Install lunavim dependencies (as root)
#https://www.lunarvim.org/docs/installation#prerequisites
RUN wget https://github.com/neovim/neovim/releases/download/v0.8.1/nvim-linux64.deb
RUN apt-get install -y ./nvim-linux64.deb make nodejs cargo g++ fzf
RUN wget https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh
RUN chown dev:dev install.sh

#Switching to user dev.
USER dev

#3.1 - Install lunavim (related with step #2)
ENV PATH="$PATH:/home/dev/.local/bin"
RUN /bin/bash ./install.sh

#3.2 - Install nerdfonts
RUN mkdir -p ~/.local/share/fonts \
	&& cd ~/.local/share/fonts \
        && git clone https://github.com/ronniedroid/getnf.git \
        && cd getnf \
        && ./install.sh \
        && getnf

#4 - Zsh config (related with #1)
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
RUN sed -i 's/robbyrussell/bira/g' ~/.zshrc

ENTRYPOINT zsh
WORKDIR /app
