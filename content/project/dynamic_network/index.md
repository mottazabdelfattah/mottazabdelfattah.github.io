---
title: Visualization Techniques for Dynamic Networks 
summary: Developing techniques for visualizing dynamic networks with a special focus on bipartite graph layout.<br/>{{< icon name="screwdriver-wrench" pack="fas" >}} R, JAVA, Servlets, HTML, JavaScript, D3.js, SVG, Canvas 
tags:
  - network, visualization, bipartite, dynamic, time, scalability
date: "2016-04-27T00:00:00Z"

# Optional external URL for project (replaces project detail page).
external_link: ''

image:
  caption: '<figcaption>Figure 1: A multi-timescale dynamic graph visualization based on the US domestic flight dataset.</figcaption>'
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
<!-- Node-link diagrams (NL) and adjacency matrices (AM) are two of the most common techniques used to visualize networks (see Figure 2). NL is easy to understand and usually preferred [^1] when the task at hand is path-related. However, the technique doesn't scale well as the density of the network grows, resulting in the famous "hair-ball" effect. AM, in contrast, provides better scalability with network density, but it comes at the cost of understandability and the screen space consumed by the technique grows quadratically as the network grows in size. In literature, several techniques have been proposed attempting to combine both NL and AM in one hybrid approach [^2]. In the real world, networks are rarely static but rather evolving (i.e., dynamic networks). Having time as an additional dimension besides network size and density makes the visualization task even more challenging. A visualization technique not only needs to be scalable with respect to size and density but also with respect to time.

<figure>
  <img src="nl_am.png" style="width:70%"/>
  <figcaption>Figure 2: Node-link diagram and adjacency matrices (AM) are two of the most common techniques used to visualize static networks.</figcaption>
</figure>


There are two main schools for visualizing dynamic networks [^3]: those who advocate for the use of animation, also referred to as "time-to-time mapping," and those who advocate for the use of the screen space, also referred to as "time-to-space mapping," to encode the time variable. In their seminal research, Tversky et al. [^4] made the case for the latter against the former. According to the "Congruence Principle", <em>the content and format of the graphic should correspond to the content and format of the concepts to be conveyed</em>. While animation might satisfy that principle, it is often too fast to be accurately apprehended and less effective than its static counterpart, and therefore, doesn't satisfy the "Apprehension Principle".  -->
<!-- The Galloping Horse problem (see Figure 3) is one example of how artists used to incorrectly draw the complex interaction of the horse's legs while it is running at high speed before stop-gap photography. -->

<!-- <figure>
  <img src="baronet-george-stubbs.jpg" style="width:100%"/>
  <figcaption>Figure 3: The Galloping Horse problem serves as a perfect illustration of the difficulty in grasping the complex interaction of the horse's legs while it is running at high speed. “Baronet” by George Stubbs, 1794.</figcaption>
</figure> -->
<!-- <figure>
  <img src="parallel_edge_splatting.jpg" style="width:100%"/>
  <figcaption>Figure 3: Parallel Edge Splatting BP layouts are juxtaposed next to each other to depict different network snapshots.</figcaption>
</figure> -->


In this project, we extended the state-of-the-art of dynamic network visualization by developing time-to-space mapping approaches based on Bipartite Layout (BP). One example is shown in Figure 1 where we visualize the US domestic flight dataset on three timescales: monthly, daily, and hourly (from top to bottom). The dataset consisting of several hundred vertices (airports), several million edges (flight connections), and more than one million time steps (from January 1st, 2000 to December 31st, 2001). 

In this <cite><a href="/publication/abdelaal-2017-multi">work</a></cite>, we interleave the graphs from the individual timepoints to improve the scalability with respect to time. However, the interleaving results in a significant amount of overdrawing, making this method only suitable for sparse networks. In <cite><a href="/publication/abdelaal-2018-clustering">a later work</a></cite>, we attempted to tackle this issue by "stacking" the individual time points instead of "interleaving" them, which proves to be beneficial in revealing the network's temporal patterns (see Figure 2).

<!-- The layout was first proposed for dynamic network visualization by Burch et al. [^5], where the different network snapshots from different time points are juxtaposed next to each other in a small multiple fashion (see Figure 3). To improve the scalability of the technique with respect to time, they later proposed interleaving the BP for different time points [^6]. 

However, such a method resulted  -->


<figure>
  <img src="flight_cluster1_interleaving.png" style="width:100%"/>
  <p style="width:100%; display:inline-block; text-align:center">
    <span style="font-size: small;">Interleaved Edge Splatting (IES)</span>
  </p>
  <img src="flight_cluster1_our.png" style="width:100%"/>
  <p style="width:100%; display:inline-block; text-align:center">
    <span style="font-size: small;">Stacked Edge Splatting (SES)</span>
  </p>
  <figcaption>Figure 2: Interleaved BP vs. Stacked BP. Stacking BP proves to be beneficial in revealing the network's temporal patterns.</figcaption>
</figure>

In later work, we introduced the <cite><a href="/publication/abdelaal-2020-time">Time-aligned Edge Plots</a></cite> as an alternative way of drawing the BP layout over time. Instead of redrawing the edges at each time point, we only draw them once, through time. In this way, we exploit the line stroke style (i.e., dashed, dotted, solid, etc.) to convey the temporal patterns in the network. Sometimes we refer to this method as "Striped BP" or "striping" for short. This method proves to be more scalable with respect to the network density (see Figure 3).

<figure>
  <img src="G5_MSV_cropped.png" style="width:33%; float:left"/>
  <img src="G5_IES_cropped.png" style="width:33%; float:left"/>
  <img src="G5_TEP_cropped.png" style="width:33%;"/>
  <p style="width:100%; display:inline-block; text-align:center">
    <span style="width:33%; float:left;font-size: small;">(a) Massive Sequence Views (MSV)</span>
    <span style="width:33%; float:left;font-size: small;">(b) Interleaved Edge Splatting (IES)</span>
    <span style="width:33%; float:left;font-size: small;">(c) Time-aligned Edge Plots (TEP)</span>
  </p>
  
  
  <figcaption>Figure 3: Time-aligned Edge Plots proves to be more scalable than current state-of-the-art with respect to the network density.</figcaption>
</figure>



We build an interactive user interface using Java-Servlets in the backend and HTML, JavaScript, and D3.js in the frontend. A demo video can be found here:

<video width="320" height="240" controls>
  <source src="TEP_video_annotated.mp4" type="video/mp4">
</video>



----


Used Tech {{< icon name="screwdriver-wrench" pack="fas" padding_right="2">}}: R, JAVA, Servlets, HTML, JavaScript, D3.js, SVG, Canvas 

<!-- HTML{{< icon name="code" pack="fas" padding_right="2">}}
JS{{< icon name="js" pack="fab" padding_right="2">}}
Java{{< icon name="java" pack="fab" padding_right="2">}}
R{{< icon name="r-project" pack="fab" padding_right="2">}} -->