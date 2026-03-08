#v({{ design.section_titles.space_above }})
#block(above: 0pt, below: 0pt)[
  #place(dx: -1.1em, dy: 0.12em)[#box(fill: rgb("111111"), width: 5pt, height: 5pt)]
  #text(fill: rgb("111111"), weight: "bold", tracking: 2pt, size: 9.5pt)[#upper[{{section_title}}]]
]
#v({{ design.section_titles.space_below }})
{% if entry_type in ["ReversedNumberedEntry"] %}
#reversed-numbered-entries(
  [
{% endif %}
