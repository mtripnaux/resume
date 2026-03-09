{% if not design.entries.short_second_row %}
{% set first_row_lines = entry.date_and_location_column.splitlines()|length %}
{% if first_row_lines == 0 %} {% set first_row_lines = 1 %} {% endif %}
{% else %}
{% set first_row_lines = entry.main_column.splitlines()|length %}
{% endif %}
#education-entry(
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
{% if design.templates.education_entry.degree_column %}
  degree-column: [
    {{ entry.degree_column|indent(4) }}
  ],
{% endif %}
{% if not design.entries.short_second_row %}
  main-column-second-row: [
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
