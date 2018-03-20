# # Start with Ubuntu 16.04 (xenial) base image [see https://hub.docker.com/_/ubuntu/ for image information]
# FROM ubuntu:16.04

# # Do all of the following commands from the /home/nuwit directory (and create that dir if it doesn't exist)
# WORKDIR /home/nuwit

# # update the apt cache and install the "cowsay" and "sudo" packages (without installing recommended packages)
# RUN apt-get update && \
# 	 apt-get install -y --no-install-recommends \
# 	 cowsay \
# 	 sudo

# # Copies the docker_entrypoint.sh script into the 
# COPY docker_entrypoint.sh .

# # export the environment variable add the /usr/games directory to the PATH so we can use the cowsay binary
# ENV PATH="$PATH:/usr/games"

# # make the `docker_entrypoint.sh` script executable
# RUN chmod +x docker_entrypoint.sh

# # When the container is run, execute the docker_entrypoint.sh script
# ENTRYPOINT ./docker_entrypoint.sh

FROM ruby:2.4.3-jessie

WORKDIR /opt/nuwit

COPY demo_app .

RUN bundle install

EXPOSE 3001

ENTRYPOINT ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "3001"]
