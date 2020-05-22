
all_ubuntu: setup_ubuntu exa_ubuntu zsh-extras hc-zenburn-emacs copy get_anaconda_ubuntu anaconda_install
all_mac: setup_mac zsh-extras hc-zenburn-emacs copy get_anaconda_mac anaconda_install

setup_ubuntu:
	sudo apt update
	sudo apt install --yes zsh emacs tree git-core unzip htop
	sudo usermod -s /bin/zsh phoenix
	sudo chsh -s `which zsh`

setup_zsh_ubuntu:
	wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
	sh install.sh

setup_mac:
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	brew install wget exa htop
	wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh

get_anaconda_ubuntu:
	wget https://repo.anaconda.com/archive/Anaconda3-2019.07-Linux-x86_64.sh -O ~/anaconda.sh

get_anaconda_mac:
	https://repo.anaconda.com/archive/Anaconda3-2019.07-MacOSX-x86_64.sh -O ~/anaconda.sh

anaconda_install:
	bash ~/anaconda.sh -b -p $HOME/anaconda
	export PATH="$HOME/anaconda/bin:$PATH"

exa_ubuntu:
	wget https://github.com/ogham/exa/releases/download/v0.8.0/exa-linux-x86_64-0.8.0.zip
	unzip exa-linux-x86_64-0.8.0.zip
	sudo mv exa-linux-x86_64 /usr/local/bin/exa
	sudo chmod ugo+x /usr/local/bin/exa


zsh-extras:
	git clone https://github.com/zakaziko99/agnosterzak-ohmyzsh-theme 
	git clone https://github.com/zdharma/fast-syntax-highlighting
	git clone https://github.com/zsh-users/zsh-autosuggestions


hc-zenburn-emacs:
	git clone https://github.com/edran/hc-zenburn-emacs



copy:
	cp -v ~/dotfiles/.screenrc ~
	cp -v ~/dotfiles/.zshrc ~
	cp -v ~/dotfiles/.gitconfig ~
	cp -v ~/dotfiles/.gitignore ~
	cp -v ~/dotfiles/tmux/.tmux.conf ~
	# cp -vr ~/dotfiles/.emacs.d ~/
	cp -v ~/dotfiles/agnosterzak-ohmyzsh-theme/agnosterzak.zsh-theme ~/.oh-my-zsh/themes
	# cp -v ~/hc-zenburn-emacs/hc-zenburn-theme.el ~/.emacs.d/themes
	cp -r ~/dotfiles/fast-syntax-highlighting ~/.oh-my-zsh/plugins
	cp -r ~/dotfiles/zsh-autosuggestions ~/.oh-my-zsh/plugins
