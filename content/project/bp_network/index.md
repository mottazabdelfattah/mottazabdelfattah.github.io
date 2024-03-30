---
title: Comparative Evaluation of Network Visualizations
summary: Developing and evaluating techniques for visualizing networks with a special focus on bipartite graph layout.<br/>{{< icon name="code" pack="fas" >}} {{< icon name="js" pack="fab" >}} {{< icon name="java" pack="fab" >}} {{< icon name="r-project" pack="fab" >}}
tags:
  - network, visualization, bipartite, evaluation, quantitative, user study 
date: "2016-04-27T00:00:00Z"

# Optional external URL for project (replaces project detail page).
external_link: ''

image:
  caption: ''
  focal_point: ""

# links:
#   - icon: html
#     icon_pack: fab
#     name: Html
#   - icon: java
#     icon_pack: fab
#     name: Java
#   - icon: javascript
#     icon_pack: fab
#     name: JS
    

---
In this project we took on the job of answering the question "what bipartite layout is good for?". Before we begin we must distguish betweem bipartite graph and bipartite layout.Bipartitie graphs are a special kind of graph where the vertices are partitioned into two disjoint sets. These graphs are often found in biological and biochemical reaction networks. To visualize bipartitie graphs we use two verticel parallel axes to denote the two set of vertices and lines to visualize the connections between them. In this work, however, we are intrested in the usage of bipartite layout for visualizing single-mode network (i.e., one set of vertices). In this case, we still have the two verticel parallel axes but the vertices are replicated on both axes with the same order (see Figure??). 

The use of bipartite layout to visualize single-mode network was propsed by Burch et al where they introdcude the idea of using it for visalzing dynamic networks (i.e., networks the change over time). To encode the time dimension, the individual networks from different timepoints are juxtaposed next to each other in a small multiples fashion. Several subsequent techniques were introduced aiming to increase the scalability of parallel edge splatting with respect to the number of timepoints, either by applying a time sliding window [12], interleaving [16], stacking [3], or by partially drawing the edges [4]. While all  this work showed that bipartite layouts can be beneficial for dynamic network visualization. The main question "what bipartite layout is good for?" remined unaswered, erepcially in comparison to other well-known layouts such as node-link diagram or adjecent matrices, which what we tried to tackle in this research (figure??). 

As seen in figure bipartite layout share some characteritics with both NL and AM. When it comes to Node Encoding, Network Layout and Cluster Encoding, the layout is more sismilar to AM than it is to NL. This suggests that BP might have similar perfromance (time ans accuracy) to AM when it comes to finding clusters in a network (T2) or identyfting the network topologcal properties (T1) or solving netweok tasks that are based on node propeties (T4). On the other hand, when it comes to Edge Encoding and Desnity Encoding, BP behaves similar to NL. This suggests that BP might have similar perfoeence to NL when it comes to netweok desnity estimation tasks (T3) or tasks that are based on edge propeties (T5). 

To validate these hypotheses, we conducted a crowdsourced user study to compare the the three layouts across five different network ananlysis tasks (figure??).  We decided to target large networks (i.e., 500 nodes). The deicion to target large networks  and focus overview tasks was driven by two reason: First, we identfied a gap in the current litertature when it comes to evaluating network visualization. As seen in fugure?? most of the previous work (maybe excpet for the work of Yoghourdjian et al. 2018) target small networks and focus on detailed tasks. Second, our excperiecne working with bipartite layout indicated that the layout might actually be befical when someone is intretsed in answering an overview task on large network thana detailed ones on small networks (see Figure large networks).

We opted for a between-subject design with three conditions, one per each layout and we aimed for we aimed for 50 participants per condition (N=150). We recuried the study paratpants through Amazon Mechanical Turk (mTurk). 

Figure?? shows the overall results. Please chech out the paper for moder details about the statistical analysis. When it comes to network class identification (T1), BP did indeed behave sismilar to AM and both were significantly more accurate than NL.  However, when it comes to cluster detection, BP and





Used Tech:
HTML{{< icon name="code" pack="fas" padding_right="2">}}
JS{{< icon name="js" pack="fab" padding_right="2">}}
Java{{< icon name="java" pack="fab" padding_right="2">}}
R{{< icon name="r-project" pack="fab" padding_right="2">}}
