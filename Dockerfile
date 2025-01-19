FROM ruby:3.2-slim

# Install essential Linux packages
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    && rm -rf /var/lib/apt/lists/*

# Set work directory
WORKDIR /site

# Install Jekyll and Bundler
RUN gem install jekyll bundler

# Copy Gemfile and Gemfile.lock
COPY Gemfile* ./

# Install gems
RUN bundle install

# Expose port 4000
EXPOSE 4000
