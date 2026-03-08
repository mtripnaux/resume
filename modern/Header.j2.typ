{% macro photo_circle() %}
#box(
  clip: true,
  radius: 50%,
  width: {{ design.header.photo_width }},
  height: {{ design.header.photo_width }},
  image("{{ cv.photo|string }}", width: 100%),
)
{% endmacro %}

// ── Full-bleed dark header banner ─────────────────────────────
#place(
  top + left,
  dx: -{{ design.page.left_margin }},
  dy: -{{ design.page.top_margin }},
  block(
    fill: rgb("0B0B0B"),
    width: 100% + {{ design.page.left_margin }} + {{ design.page.right_margin }},
    height: 5.2cm,
    inset: (
      left: {{ design.page.left_margin }},
      right: {{ design.page.right_margin }},
      top: 1.0cm,
      bottom: 0.6cm,
    ),
  )[
    #align(horizon + left)[
    #set text(fill: white, size: 8.5pt)
{% if cv.photo %}
    #grid(
      columns: (auto, 1fr),
      column-gutter: 0.7cm,
      align: horizon,
      [{{ photo_circle() }}],
      [
{% endif %}
    #text(fill: white, size: 34pt, weight: "black", tracking: -0.5pt)[{{ cv._plain_name }}]
{% if cv.headline %}
    #parbreak()
    #text(fill: white, size: 10.5pt, style: "italic")[{{ cv.headline }}]
{% endif %}
    #v(0.5cm)
    #connections(
{% for connection in cv._connections %}
      [{{ connection }}],
{% endfor %}
    )
{% if cv.photo %}
      ]
    )
{% endif %}
    ]
  ]
)

// ── Reserve vertical space for header block ────────────────────
#v(5.2cm - {{ design.page.top_margin }} + 0.5cm)
