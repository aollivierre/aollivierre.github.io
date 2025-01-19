---
layout: page
title: Categories
permalink: /categories/
---

<div class="categories-list">
  {% for category in site.categories %}
    <div class="category-group">
      {% capture category_name %}{{ category | first }}{% endcapture %}
      <h2 id="{{ category_name | slugize }}">{{ category_name }}</h2>
      <ul>
      {% for post in site.categories[category_name] %}
        <li>
          <span class="post-date">{{ post.date | date: "%B %d, %Y" }}</span>
          <a href="{{ post.url | relative_url }}">{{ post.title }}</a>
        </li>
      {% endfor %}
      </ul>
    </div>
  {% endfor %}
</div>
