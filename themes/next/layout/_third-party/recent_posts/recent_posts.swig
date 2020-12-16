<!-- 添加近期文章 -->
{% if theme.recent_posts.enable %}
  <div class="links-of-blogroll motion-element {{ "links-of-blogroll-" + theme.recent_posts.layout  }}">
    <div class="links-of-blogroll-title">
      <!-- modify icon to fire by szw -->
      <i class="fa fa-history fa-{{ theme.recent_posts.icon | lower }}" aria-hidden="true"></i>
      {{ __('sidebar.recent_posts') }}
    </div>
    <ul class="links-of-blogroll-list">
      {% set posts = site.posts %}
      {% for post in posts %}
        <li>
          <a href="{{ url_for(post.path) }}" title="{{ post.title }}" target="_blank">{{ post.title }}</a>
        </li>
      {% endfor %}
    </ul>
  </div>
{% endif %}