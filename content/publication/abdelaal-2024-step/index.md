---
title: 'STEP: Sequence of time-aligned edge plots'
authors:
- M Abdelaal
- F Kannenberg
- A Lhuillier
- M Hlawatsch
- A Menges
- D Weiskopf
date: '2025-01-27'
publishDate: '2024-10-07T10:57:04.464623Z'
publication_types:
- article-journal
publication: '*Information Visualization*'

abstract: 'We present sequence of time-aligned edge plots (STEP): a sequence- and edge-scalable visualization of
dynamic networks and, more broadly, graph ensembles. We construct the graph sequence by ordering the
individual graphs based on specific criteria, such as time for dynamic networks. To achieve scalability with
respect to long sequences, we partition the sequence into equal-sized subsequences. Each subsequence is
represented by a horizontal axis placed between two vertical axes. The horizontal axis depicts the order
within the subsequence, while the two vertical axes depict the source and destination vertices. Edges within
each subsequence are depicted as segmented lines extending from the source vertices on the left to the destination vertices on the right throughout the entire subsequence, and only the segments corresponding to the sequence members where the edges occur are drawn. By partitioning the sequence, STEP provides an overview of the graphs’ structural changes and avoids aspect ratio distortion. We showcase the utility of STEP for two realistic datasets. Additionally, we evaluate our approach by qualitatively comparing it against three state-of-the-art techniques using synthetic graphs with varying complexities. Furthermore, we evaluate the
generalizability of STEP by applying it to a graph ensemble dataset from the architecture domain.'

tags: [dynamic, graphs, visualization, bipartite, graph, ensembles, sequence, time, architecture]

links:
- name: "Web Prototype"
  url: "https://dy-graph-vis.vercel.app/"
url_pdf: https://journals.sagepub.com/doi/pdf/10.1177/14738716241265111
url_code: 'https://github.com/mottazabdelfattah/dy-graph-vis'
url_dataset: 'https://doi.org/10.18419/DARUS-4198'
url_poster: ''
url_project: ''
url_slides: ''
#url_source: ''
# url_video: 'ice_video_20181008-210906.mp4'



projects: ['dynamic_network']
---
