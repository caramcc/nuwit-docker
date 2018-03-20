# Start with the ruby 2.4.3 base image. 
# Sidenote: this image runs on Debian (Jessie), a different Linux distribution that's similar to Ubuntu.
FROM ruby:2.4.3-jessie

# keep the Working directory at /opt/nuwit
WORKDIR /opt/nuwit

# Now we're copying the entire demo_app/ directory into our working directory
COPY demo_app .

# Bundler is a Ruby package manager. It installs the packages we need (defined in demo_app/Gemfile).
RUN bundle install

# Now we're using the array-style command to start a rails server.
# running 
ENTRYPOINT ["rails", "server", "-b", "0.0.0.0", "-p", "3001"]
