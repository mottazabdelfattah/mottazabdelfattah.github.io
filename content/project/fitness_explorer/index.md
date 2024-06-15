---
title: Fitness Landscape Explorer 
summary: An interactive interface for exploring fitness landscapes in the context of archiecture design optimization.<br/>{{< icon name="screwdriver-wrench" pack="fas" >}} C#, .NET, WPF, Rhino/Grasshopper 
tags:
  - architecture, design, optimization, glyph
date: '2024-02-14T00:00:00Z'

# Optional external URL for project (replaces project detail page).
external_link: ''

image:
  caption: '<figcaption>Figure 1: An interactive interface for exploring fitness landscapes.</figcaption>'
  focal_point: ""
  preview_only: false

# links:
#   - icon: twitter
#     icon_pack: fab
#     name: Follow
#     url: https://twitter.com/exc_intcdc
# url_code: ''
# url_pdf: ''
# url_slides: ''
# url_video: ''

# Slides (optional).
#   Associate this project with Markdown slides.
#   Simply enter your slide deck's filename without extension.
#   E.g. `slides = "example-slides"` references `content/slides/example-slides.md`.
#   Otherwise, set `slides = ""`.
#slides: example
---


In architectural design optimization, fitness landscapes are used to visualize design space parameters in relation to one or more objective functions for which they are being optimized. In this project, we designed and built an interactive user interface for exploring fitness landscapes.

As seen in Figure 1, our user interface offers two alternative representations for exploring fitness landscapes: a continuous density map and a discrete glyph-based map. Objective values and parameter views are updated based on the cursor position. The glyph-based map features a portal cursor for semantic zoom, displaying data in a separate portal lens view. 3D renderings of the underlying structure are displayed for selected parameter constellations. Furthermore, the exploration history shows which areas of the landscape have been investigated.

A teaser video can be found <a href="teaser.mp4">here</a>. 

This interactive interface was used by our collaborators to explore the optimization space of coreless filament wound structures. A publication will appear soon.







----



Used Tech {{< icon name="screwdriver-wrench" pack="fas" padding_right="2">}}: C#, .NET, WPF, Rhino/Grasshopper