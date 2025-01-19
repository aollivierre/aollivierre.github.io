# Cloud Command Blog Setup Guide

This guide documents the complete process of setting up a Jekyll blog using GitHub Pages, Docker, and a custom domain with Cloudflare.

## Prerequisites

- Ubuntu Server (or any Linux system)
- Docker and Docker Compose
- Git installed
- GitHub account
- Domain name (we used cloudcommand.org)
- Cloudflare account

## Step 1: Install Docker and Docker Compose

```bash
# Update package list
sudo apt update

# Install prerequisites
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

# Add Docker's official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Add Docker repository
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update package list again
sudo apt update

# Install Docker Engine and Docker Compose
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose

# Add your user to docker group
sudo usermod -aG docker $USER

# Apply group changes
newgrp docker
```

## Step 2: Set Up GitHub Repository

1. Create a new repository named `username.github.io`
2. Clone it locally:
```bash
git clone https://github.com/username/username.github.io.git
cd username.github.io
```

## Step 3: Configure Docker for Jekyll

Create the following files in your repository:

### Dockerfile
```dockerfile
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

# Copy Gemfile
COPY Gemfile* ./

# Install dependencies
RUN bundle install

# Expose port 4000
EXPOSE 4000
```

### docker-compose.yml
```yaml
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
```

### Gemfile
```ruby
source "https://rubygems.org"

gem "jekyll", "~> 4.3.3"
gem "minima"

group :jekyll_plugins do
  gem "jekyll-feed"
  gem "jekyll-seo-tag"
  gem "jekyll-sitemap"
end
```

## Step 4: Configure Jekyll

Create the following configuration files:

### _config.yml
```yaml
title: Cloud Command
email: AbdullahOllivierre@gmail.com
description: >-
  A modern blog about cloud computing, automation, and DevOps practices.
baseurl: ""
url: "https://cloudcommand.org"
twitter_username: Ollivierre_A
github_username: aollivierre

theme: minima
plugins:
  - jekyll-feed
  - jekyll-seo-tag
  - jekyll-sitemap

# Header pages
header_pages:
  - about.md
  - categories/index.md
  - tags/index.md

# Defaults for posts
defaults:
  -
    scope:
      path: ""
      type: "posts"
    values:
      layout: post
      author: Abdullah Ollivierre
```

## Step 5: Set Up Blog Structure

Create the following directories:
```bash
mkdir -p _posts _layouts _includes assets/images categories tags
```

## Step 6: Configure Cloudflare DNS

Create a zone file with these records:
```bind
; Zone file for cloudcommand.org
$TTL 3600
@       IN      A       185.199.108.153  ; cf_tags=cf-proxied:true
@       IN      A       185.199.109.153  ; cf_tags=cf-proxied:true
@       IN      A       185.199.110.153  ; cf_tags=cf-proxied:true
@       IN      A       185.199.111.153  ; cf_tags=cf-proxied:true

@       IN      AAAA    2606:50c0:8000::153  ; cf_tags=cf-proxied:true
@       IN      AAAA    2606:50c0:8001::153  ; cf_tags=cf-proxied:true
@       IN      AAAA    2606:50c0:8002::153  ; cf_tags=cf-proxied:true
@       IN      AAAA    2606:50c0:8003::153  ; cf_tags=cf-proxied:true

www     IN      CNAME   aollivierre.github.io.  ; cf_tags=cf-proxied:true
```

## Step 7: Run Jekyll Locally

```bash
# Build and start Jekyll
docker-compose up --build

# Access your blog at
http://your-vm-ip:4000
```

## Step 8: Creating Blog Posts

Posts go in the `_posts` directory with the filename format: `YYYY-MM-DD-title.md`

Example post:
```markdown
---
layout: post
title: "Welcome to Cloud Command"
date: 2024-01-18 12:00:00 -0500
categories: 
  - Introduction
  - DevOps
tags:
  - welcome
  - cloud-computing
  - devops
  - automation
author: Abdullah Ollivierre
---

Your post content here...
```

## Common Issues and Solutions

1. **Docker Permission Issues**:
   - Solution: Add user to docker group and run `newgrp docker`

2. **Jekyll Port Already in Use**:
   - Solution: `docker-compose down` then `docker-compose up`

3. **Sass Deprecation Warnings**:
   - These are normal with the current minima theme and don't affect functionality

## Next Steps

- [ ] Customize theme
- [ ] Add more blog posts
- [ ] Set up CI/CD
- [ ] Add commenting system
- [ ] Add analytics

## Resources

- [Jekyll Documentation](https://jekyllrb.com/docs/)
- [GitHub Pages Documentation](https://docs.github.com/en/pages)
- [Cloudflare Documentation](https://developers.cloudflare.com/dns/)