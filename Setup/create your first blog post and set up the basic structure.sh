# Create essential directories
mkdir -p _posts _layouts _includes assets/images

# Create your first blog post
cat > _posts/2024-01-18-welcome-to-cloud-command.md << 'EOL'
---
layout: post
title: "Welcome to Cloud Command"
date: 2024-01-18
categories: [blog, introduction]
---

Welcome to Cloud Command! I'm Abdullah Ollivierre, and this blog will be my space to share insights about cloud computing, automation, and DevOps practices. 

## What to Expect

In this blog, I'll be covering:
- Cloud computing best practices
- DevOps automation techniques
- Infrastructure as Code (IaC)
- Container orchestration
- And much more!

Stay tuned for more content coming soon!
EOL

# Create the main configuration file
cat > _config.yml << 'EOL'
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

# Additional settings
show_excerpts: true
header_pages:
  - about.md
  - projects.md

# Build settings
markdown: kramdown
EOL

# Create an about page
cat > about.md << 'EOL'
---
layout: page
title: About
permalink: /about/
---

I'm a DevOps enthusiast and cloud computing professional, passionate about automation and building efficient systems. This blog serves as a platform to share my experiences and insights in the world of modern infrastructure and cloud technologies.

Feel free to connect with me on [Twitter](https://x.com/Ollivierre_A) or check out my projects on [GitHub](https://github.com/aollivierre).
EOL