# Table of Contents

<!-- toc -->

- [Demo 0: Installing](demo-0-installing)
- [Demo 1: The Basics](demo-1-the-basics)
- [Demo 2: Serve an App](demo-2-serve-an-app)

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

We'll be building an image and running a container that prints information about the operating system and kernel.

## Dockerfile

Open up the `Dockerfile`. Each line starts with an instruction in all-caps: this is the command that we're giving to the Docker daemon when we run `docker build` to tell it how to build our image.


FROM - specifies the base image we're starting off of. Docker images are like onions: they have layers.
WORKDIR - sets the working directory to the path specified
RUN - executes a command against the container, like installing a package or changing file permissions
COPY - copies specified files and directories from your host machine into the container
ENV - sets an environment variable
ENTRYPOINT - denotes the command that should be executed when the container is run

Within the Dockerfile, you should see comments annotating how we're using these commands more specifically in this case.

## Docker build

[docs](https://docs.docker.com/engine/reference/commandline/build/)

The `build` command is used to build images from a Dockerfile in the path that's passed to it. (In this case, the path is `.`, the current working directory.)

The `--tag` options allows us to label the container we're writing with a name and a version. (In this case, we're naming it `nuwit` and giving it the version `demo-1`.)

`docker build --tag nuwit:demo-1 .`

To confirm that it worked, you can run the `docker images` command, which lists the Docker images you have locally. You should see the image we just created in the output.

`docker images`

## Docker run

Now, we can run the image we just built. Use `docker run` with the iamge name and version (`nuwit:demo-1`) to start a container:

`docker run nuwit:demo-1`


You should see output similar to the following:
```
 _______________________________________
/ Linux 5aa478881ed5 4.4.86-boot2docker \
| #1 SMP Tue Sep 5 23:59:54 UTC 2017    |
\ x86_64 x86_64 x86_64 GNU/Linux        /
 ---------------------------------------
        \   ^__^
         \  (oo)\_______
            (__)\       )\/\
                ||----w |
                ||     ||
```


# Demo 2: Serve an App

## Precursor: The Rails App, a crash-course

I've put together an extremely bare-bones Rails app in the `demo_app/` directory that we'll be using for this section.

Note: A lot of this Rails app is boilerplate, and we're skipping over the details in this talk. If you're interested in learning about Rails, I personally recomment [Rails Tutorial](https://www.railstutorial.org/book/beginning).

### Files We Care About

#### View files

These define the ERB-interpolated HTML that you'll see when you navigate to a page.

The ones we care about live in:
`demo_app/app/views/robot_proof/*`

#### Controllers

Controllers are the glue between The Business Logic (for our purposes: not pictured) and the Views. 

`demo_app/app/controllers/robot_proof_controller.rb` 

#### Routes

We're also interested in the Routes file, which defines which views correspond to which URLs.

In a Rails app, that lives in a routes file:

`demo_app/config/routes.rb`

## Build this container!

Notice that the Dockerfile has been updated. We're now building off of a Ruby base container. This is one convience of Docker: the Ruby base container that someone else wrote already sets up a container so we can drop in a Ruby app and run it without worrying about installing a Ruby runtime or other various libraries that we need.

The build command should look familiar. This time we're tagging our image with `demo-2`:

`docker build --tag nuwit:demo-2 .`

## Run the new container!

We need a few more flags to get our container running like we expect:

`docker run  -p 3001:3001 -v $(pwd)/demo_app:/opt/nuwit nuwit:demo-2`


### Exposing Ports:

The `-p` flag is used to expose ports from our container to our host machine (your local computer).

Specifically, `-p 3001:3001` tells the docker engine to map port 3001 on the host to port 3001 on our container.

#### Why do we care?

This allows us to access our app (running on port 3001 in our container) from our host machine!

#### Check it out!

Navigate to http://localhost:3001/ in your browser!


### Mounting volumes:

The `-v` flag is used to mount a volume from your host machine onto your container.

Specifically, `-v $(pwd)/demo_app:/opt/nuwit` tells the docker engine to sync our `demo_app/` directory from our host to the `/opt/nuwit` directory on our container.

#### Why do we care?

This allows us to make changes locally that will immediately get mirrored to our application in our container. That means we don't need to rebuild the container every time we want to make a change to our app!

#### Check it out!

* Navigate to http://localhost:3001/robot_proof/certify in your browser.
  * Find the layout unappealing. I'm an infrastructure engineer, not a designer!
  * Find the content amusing and/or patronizing. How do you do, fellow kids?

* Open up this file: `demo_app/app/controllers/robot_proof_controller.rb`

* Change the `name` variable to your name (or my name, or your professor's name, or your cat's name.)
  * Save the file

* Refresh the page. Look, the text changed!
