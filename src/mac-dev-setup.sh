#!/bin/bash

# Create a folder who contains downloaded things for the setup
INSTALL_FOLDER=~/.macsetup
mkdir -p $INSTALL_FOLDER
MAC_SETUP_PROFILE=$INSTALL_FOLDER/macsetup_profile

# install brew
if ! hash brew
then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  brew update
else
  printf "\e[93m%s\e[m\n" "You already have brew installed."
fi

# CURL / WGET
brew install curl
brew install wget

{
  # shellcheck disable=SC2016
  echo 'export PATH="/usr/local/opt/curl/bin:$PATH"'
  # shellcheck disable=SC2016
  echo 'export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"'
  # shellcheck disable=SC2016
  echo 'export PATH="/usr/local/opt/sqlite/bin:$PATH"'
}>>$MAC_SETUP_PROFILE

# git
brew install git                                                                                      # https://formulae.brew.sh/formula/git
# Adding git aliases (https://github.com/thomaspoignant/gitalias)
# git clone https://github.com/thomaspoignant/gitalias.git $INSTALL_FOLDER/gitalias && echo -e "[include]\n    path = $INSTALL_FOLDER/gitalias/.gitalias\n$(cat ~/.gitconfig)" > ~/.gitconfig

# brew install git-secrets                                                                              # git hook to check if you are pushing aws secret (https://github.com/awslabs/git-secrets)
# git secrets --register-aws --global
# git secrets --install ~/.git-templates/git-secrets
# git config --global init.templateDir ~/.git-templates/git-secrets

# ZSH
brew install zsh zsh-completions                                                                      # Install zsh and zsh completions
sudo chmod -R 755 /usr/local/share/zsh
sudo chown -R root:staff /usr/local/share/zsh
{
  echo "if type brew &>/dev/null; then"
  echo "  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH"
  echo "  autoload -Uz compinit"
  echo "  compinit"
  echo "fi"
} >>$MAC_SETUP_PROFILE

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"# Install oh-my-zsh on top of zsh to getting additional functionality
# Terminal replacement https://www.iterm2.com
brew install --cask iterm2
# Pimp command line
brew install micro                                                                                    # replacement for nano/vi
brew install lsd                                                                                      # replacement for ls
{
  echo "alias ls='lsd'"
  echo "alias l='ls -l'"
  echo "alias la='ls -a'"
  echo "alias lla='ls -la'"
  echo "alias lt='ls --tree'"
} >>$MAC_SETUP_PROFILE

brew install tree
brew install ack
brew install bash-completion
brew install jq
brew install htop
brew install tldr
brew install coreutils
brew install watch

brew install z
touch ~/.z
echo '. /usr/local/etc/profile.d/z.sh' >> $MAC_SETUP_PROFILE

brew install ctop

# fonts (https://github.com/tonsky/FiraCode/wiki/Intellij-products-instructions)
brew tap homebrew/cask-fonts
brew install --cask font-jetbrains-mono

# Browser
brew install --cask google-chrome
brew install --cask firefox
brew install --cask microsoft-edge

# Music / Video
brew install --cask spotify
brew install --cask vlc

# Productivity
brew install --cask evernote                                                                            # cloud note
brew install --cask kap                                                                                 # video screenshot
brew install --cask rectangle                                                                           # manage windows

# Communication
brew install --cask slack
brew install --cask whatsapp

# Dev tools
brew install --cask ngrok                                                                               # tunnel localhost over internet.
brew install --cask postman                                                                             # Postman makes sending API requests simple.

# IDE
brew install --cask jetbrains-toolbox
brew install --cask visual-studio-code

# Language
## Node / Javascript
mkdir ~/.nvm
brew install nvm                                                                                     # choose your version of npm
nvm install node                                                                                     # "node" is an alias for the latest version
brew install yarn                                                                                    # Dependencies management for node


## Java
curl -s "https://get.sdkman.io" | bash                                                               # sdkman is a tool to manage multiple version of java
source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk install java
brew install maven
brew install gradle


## python
echo "export PATH=\"/usr/local/opt/python/libexec/bin:\$PATH\"" >> $MAC_SETUP_PROFILE
brew install python
pip install --user pipenv
pip install --upgrade setuptools
pip install --upgrade pip
brew install pyenv
# shellcheck disable=SC2016
echo 'eval "$(pyenv init -)"' >> $MAC_SETUP_PROFILE


## terraform
brew install terraform
terraform -v

# Databases
brew install --cask dbeaver-community # db viewer
brew install libpq                  # postgre command line
brew link --force libpq
# shellcheck disable=SC2016
echo 'export PATH="/usr/local/opt/libpq/bin:$PATH"' >> $MAC_SETUP_PROFILE

# SFTP
brew install --cask cyberduck

# Docker
brew install --cask docker
brew install bash-completion
brew install docker-completion
brew install docker-compose-completion
brew install docker-machine-completion

# AWS command line
brew install awscli # Official command line
pip3 install saws    # A supercharged AWS command line interface (CLI).

#office 
brew install --cask microsoft-office

# K8S command line
brew install kubectx
brew install asdf
asdf install kubectl latest

# reload profile files.
{
  echo "source $MAC_SETUP_PROFILE # alias and things added by mac_setup script"
}>>"$HOME/.zsh_profile"
# shellcheck disable=SC1090
source "$HOME/.zsh_profile"

{
  echo "source $MAC_SETUP_PROFILE # alias and things added by mac_setup script"
}>>~/.bash_profile
# shellcheck disable=SC1090
source ~/.bash_profile
