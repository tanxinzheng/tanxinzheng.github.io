{%- if theme.github_badge.enable %}
<div class="github-badge">
    <a style="color: #fff" rel="license" href="http://halo.run" target="_blank" title="由 Halo 驱动" data-pjax-state="">
    <span class="badge-subject">Powered</span><span class="badge-value bg-blue">Halo</span></a>
</div>
{%- for badge in theme.github_badge.badges.toArray() %}
<div class="github-badge">
    <a style="color: #fff" rel="license" href="{{badge.href}}" target="_blank" title="{{badge.title}}" data-pjax-state="">
    <span class="badge-subject">{{badge.subject}}</span><span class="badge-value bg-blue">{{badge.value}}</span></a>
</div>
{%- endfor %}

{%- endif %}