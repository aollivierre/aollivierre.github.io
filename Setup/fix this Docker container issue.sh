# First, stop any running containers
docker-compose down

# Clean up Docker resources
docker system prune -f

# Update docker-compose.yml
cat << 'EOL' > docker-compose.yml
version: '3'
services:
  jekyll:
    build: .
    volumes:
      - .:/site
    ports:
      - "4000:4000"
    environment:
      - JEKYLL_ENV=development
    command: bundle exec jekyll serve --host 0.0.0.0
EOL

# Update Dockerfile
cat << 'EOL' > Dockerfile
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
EOL

# Update Gemfile
cat << 'EOL' > Gemfile
source "https://rubygems.org"

gem "jekyll", "~> 4.3.3"
gem "minima"

group :jekyll_plugins do
  gem "jekyll-feed"
  gem "jekyll-seo-tag"
  gem "jekyll-sitemap"
end
EOL

# Now try building and running again
docker-compose build --no-cache
docker-compose up