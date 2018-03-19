# Table of Contents

<!-- toc -->

- [Demo 0: Installing](demo-0-installing)
- [Demo 1: The Basics](demo-1-the-basics)

<!-- tocstop -->

# Demo 0: Installing

## macOS

### With Homebrew

Run `make install_mac` to install both Homebrew (macOS package manager) and Docker.

If you already have Homebrew installed, run:

`brew cask install docker`

### GUI installer

[Docker for Mac](https://docs.docker.com/docker-for-mac/install/) - install the `Stable channel`


## Windows

[Docker for Windows](https://docs.docker.com/docker-for-windows/install/) - install the `Stable channel`

Note: I haven't worked with Docker for Windows and unfortunately can't provide much guidance beyond providing documentation.

## Linux

### Ubuntu

#### Install from Docker documentation

[Docker CE for Ubuntu](https://docs.docker.com/install/linux/docker-ce/ubuntu/#install-docker-ce)

#### Install with the provided Makefile:

`make install_ubuntu`

Note that this assumes you have `x86_64` or `amd64` architecture. If you don't know, it's probably one of these :)

If you are using a different chip, you can pass an `ARCH=<chip>`to the make target (e.g. `make install_ubuntu ARCH=armfh`) :

architecture   | chip value
---------------|-----------------
x86_64 / amd64 | amd64
armhf          | armfh
IBM Power      | ppc64le
IBM Z          | s390x


### Other Linux Distributions

* [Debian](https://docs.docker.com/install/linux/docker-ce/debian/)
* [CentOS](https://docs.docker.com/install/linux/docker-ce/centos/)
* [Fedora](https://docs.docker.com/install/linux/docker-ce/fedora/)



# Demo 1: The Basics

The first demo will cover:

- basic Dockerfile syntax

- building Docker images

- running Docker containers

## Dockerfile

## Docker build

[docs](https://docs.docker.com/engine/reference/commandline/build/)

`docker build --tag nuwit:demo-1 .`

confirm that it worked:

`docker images`

## Docker run


