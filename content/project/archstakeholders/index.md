---
title: Timber Stakeholders Explorer 
summary: An interactive web interface for exploring the stakeholder network of the multi-storey timber design and construction sector.<br/>{{< icon name="screwdriver-wrench" pack="fas" >}} D3js, leaflet, Javascript, HTML, CSS
tags:
  - architecture, engineering, construction, stakeholders, timber
date: '2024-02-14T00:00:00Z'

# Optional external URL for project (replaces project detail page).
external_link: ''

image:
  caption: '<figcaption>Figure 1: Projects Network. Projects are ring nodes. Flags are stakeholder headquarters locations. Colored dots are stakeholder type.</figcaption>'
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

In this project, we took on the task of visualizing the stakeholder network of the multi-storey timber design and construction sector. This visualization prototype was used by our collaborators to answer qualitative questions about the connection between architectural variety in timber construction and the stakeholders involved.

We provide two interactive ways of visualizing the stakeholder network: either as a node-link diagram with different encoding options, as seen in Figures 1 and 2, or as an interactive geographical map, as seen in Figure 3.

<figure>
  <img src="buildings-13-02287-g0A1-550.jpg" style="width:100%"/>
  <figcaption>Figure 2: Timber Stakeholders Explorer user interface. (a) Graph controls, including Graph Type, Graph Settings, Filtering, and empty Info Panel. (b) Info Panel showing example stakeholder information. (c) Info Panel showing example project information. (d) Stakeholder node with Ring Connectors. (e) Stakeholder node without Ring Connectors. (f) Stakeholder node with Label. (g) Stakeholder node without Label. (h) example Project cluster with Links. (i) example Project cluster without Links. (j) SCN without Contours. (k) SCN with Contours. (l) Stakeholders GeoMap without Color by Stakeholder Type. (m) Stakeholders GeoMap with Color by Stakeholder Type. (n) Stakeholder Encoding by Type. (o) Stakeholder Encoding by Country. (p) Stakeholder Encoding Both (Type and Country).</figcaption>
</figure>


<figure>
  <img src="bigImage.png" style="width:100%"/>
  <figcaption>Figure 3: Map of stakeholder locations. Dots represent cities where at least one stakeholder is headquartered.</figcaption>
</figure>


A live prototype can be found <a href="https://archstakeholders.github.io/">here</a>. Please read <cite><a href="/publication/orozco-2023-advanced">our paper</a></cite> for mere details.




----



Used Tech {{< icon name="screwdriver-wrench" pack="fas" padding_right="2">}}: D3js, leaflet, Javascript, HTML, CSS