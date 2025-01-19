---
layout: page
title: Tags
permalink: /tags/
---

<div class="tags-list">
  {% assign tags = site.tags | sort %}
  {% for tag in tags %}
    <div class="tag-group">
      {% capture tag_name %}{{ tag | first }}{% endcapture %}
      <h2 id="{{ tag_name | slugize }}">#{{ tag_name }}</h2>
      <ul>
      {% for post in site.tags[tag_name] %}
        <li>
          <span class="post-date">{{ post.date | date: "%B %d, %Y" }}</span>
          <a href="{{ post.url | relative_url }}">{{ post.title }}</a>
        </li>
      {% endfor %}
      </ul>
    </div>
  {% endfor %}
</div>
