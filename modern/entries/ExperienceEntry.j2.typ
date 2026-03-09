{% if not design.entries.short_second_row %}
{% set first_row_lines = entry.date_and_location_column.splitlines()|length %}
{% if first_row_lines == 0 %} {% set first_row_lines = 1 %} {% endif %}
{% else %}
{% set first_row_lines = entry.main_column.splitlines()|length %}
{% endif %}
#regular-entry(
  [
{% for line in entry.main_column.splitlines()[:first_row_lines] %}
    {{ line|indent(4) }}
{% if loop.first %}
    #v(0.25em)
{% endif %}

{% endfor %}
  ],
  [
{% for line in entry.date_and_location_column.splitlines() %}
    {{ line|indent(4) }}

{% endfor %}
  ],
{% if not design.entries.short_second_row %}
  main-column-second-row: [
    #set list(marker: text(fill: {{ design.colors.body.as_rgb() }}.transparentize(45%))[{{ design.entries.highlights.bullet }}], indent: {{ design.entries.highlights.space_left }}, body-indent: 0.4em)
    #show list.item: it => text(fill: {{ design.colors.body.as_rgb() }}.transparentize(45%))[#it]
{% for line in entry.main_column.splitlines()[first_row_lines:] %}
    {{ line|indent(4) }}
{% if line.strip().startswith('#summary[') %}
    #v({{ design.entries.highlights.space_between_items }}, weak: false)
{% else %}

{% endif %}
{% endfor %}
  ],
{% endif %}
)
