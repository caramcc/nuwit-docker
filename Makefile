# for linux installs - chip architecture - options: amd64, armfh, ppc64el, s390x
ARCH := amd64

install_mac:
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	brew cask install docker

install_ubuntu:
	sudo apt-get update
	sudo apt-get install apt-transport-https ca-certificates curl software-properties-common
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
	sudo apt-key fingerprint 0EBFCD88
	sudo add-apt-repository deb [arch=$(ARCH)] https://download.docker.com/linux/ubuntu $(shell lsb_release -cs) stable
	sudo apt-get install docker-ce
