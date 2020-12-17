{% if theme.tag3dcloud.enable and site.tags.length > 1 %}
<script type="text/javascript" charset="utf-8" src="/js/tagcloud.js"></script>
<script type="text/javascript" charset="utf-8" src="/js/tagcanvas.js"></script>
<div class="widget-wrap">
    <div name="tagsCloudCanvasContainer" class="widget tagcloud" style="text-align: center;">
        <canvas width="600" height="400" id="resCanvas">
            {{ list_tags({suffix:'index.html'}) }}
        </canvas>
    </div>
</div>
{% endif %}