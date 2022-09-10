FROM ubuntu

RUN apt-get update 
RUN apt-get install -y neovim curl wget zsh git

#Zsh config
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
RUN sed -i 's/robbyrussell/bira/g' ~/.zshrc
