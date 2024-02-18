# Generate a dynamically evolving random graph based on Barabási-Albert model, which adds vertices and edges using preferential attachment and deletes nodes randomly. 
# This implementation follows the method probosed by: Cooper, Colin, Alan Frieze, and Juan Vera. "Random deletion in a scale-free random graph process." Internet Mathematics 1.4 (2004): 463-483. 
require(stsm)
require(igraph)


########################## initial parameters ##############################
timepoints <- 100				# number of timepoints
k <- 4							# nb edges added/deleted 
alpha <- 0.6#0.6#0.85#0.9
a <- alpha1 <- 0.2#0.2#0.75#0.8 				# prob. of adding new node
b <- alpha0 <- 0.35#0.3#0.01#0.01				# prob. of deleting k random edges
s <- alpha - alpha1				# prob. of adding k random edges to existing nodes
r <- 1.0 - alpha - alpha0 		# prob. of deleteing a random node

numberofInitialNodes <- max(c(2, k))
nodes <- list()				# key-value pairs of (nodeID -> nodeDegree)
allNodesNames <- as.character(seq(1,timepoints,1))
usedNames <- list()

# define dataframe to store edges in the current timepoint
edges <- data.frame(matrix(ncol = 3, nrow = 0))	
columnNames <- c("src", "target", "weight")
colnames(edges) <- columnNames


defaultEdgeWeight <- 1
densities <- c()	# storing graph density at each timepoint 

# csv output file
fName <- paste("./barabasi.dynamic.graph.deletion_k", k, "_t", timepoints, "_alpha", alpha, "_alphaZero", alpha0, "_alphaOne", alpha1, sep="")
svgFileName <- paste(fName, ".svg", sep="")
csvFileName <- paste(fName, ".csv", sep="")
txtFileName <- paste(fName, ".txt", sep="")

fn <- csvFileName
if (file.exists(fn)) file.remove(fn)	#Delete file if it exists

bufferSize = 1000

######################### auxlury functions ############################
# update nodes array
updateNodes <- function (edgeList){
	nodes <- list();
	i <- 1
	while(i <= nrow(edgeList)){
		src <- edgeList[i, 1];
		target <- edgeList[i, 2];
		weight <- edgeList[i, 3];
		
		degSrc <- nodes[[as.character(src)]]
		if(is.null(degSrc))
			degSrc <- 0

		degTarget <- nodes[[as.character(target)]]
		if(is.null(degTarget))
			degTarget <- 0
			
		if(weight > 0){	# edge is not deleted
			degSrc <- degSrc + 1
			degTarget <- degTarget + 1
		}
		
		nodes[[as.character(src)]] <- degSrc
		nodes[[as.character(target)]] <- degTarget
		 
		i <- i + 1
	}
	
	return(nodes)
}


# given a node id remove all edges to/from this node
removeVertexEdges <- function(nID, edgeList) {
  rows <- c()
  i <- 1
  while(i <= nrow(edgeList)){
    if(edgeList[i , 1] == nID || edgeList[i , 2] == nID)
      rows[length(rows) + 1] <- i
    i <- i + 1
  }
  
  if(length(rows) > 0)
    edgeList <- edgeList[-rows,]
  
  return(edgeList)
}

# sum of degrees of all nodes in the graph
graphDegree <- function(mylst) {
	sumDegrees <- 0;
	i <- 1
	while(i <= length(mylst)){
		sumDegrees <- sumDegrees + mylst[[i]] + 1
		i <- i + 1
	}
	return(sumDegrees)
}


####################### create an initial graph (t = 1) ######################
initNodes <- sample(allNodesNames, numberofInitialNodes, replace=FALSE) # random nodes names
usedNames <- initNodes
# add edges
for(i in seq(1,length(initNodes),by=1)){
	j <- i + 1
	while(j <= numberofInitialNodes){
		edges[nrow(edges) + 1,] = list(initNodes[i],initNodes[j],defaultEdgeWeight) 
		j <- j + 1
	}
}

# update nodes list
nodes <- updateNodes(edges)

#write first timepoint
fileBuffer <- data.frame(timepoint = 1, src = as.integer(edges[,1]), target = as.integer(edges[,2]), weight= as.double(edges[,3]))

# define dataframe to store edges at all timepoints (used later for small multiples plot)
allEdges <- data.frame(src = as.integer(edges[,1]), target = as.integer(edges[,2]), time = 1, weight= as.double(edges[,3]))

#update densities
densities[1] <- nrow(edges)/length(nodes)


############################ main loop (t >= 2) ###############################
for(i in seq(2,timepoints,by=1)){
  
  ############# step 1:  With probability r we delete a randomly chosen vertex x ############
  rnd <- runif(1);
  if(rnd < r && length(nodes) > 0){
	x <- as.integer(runif(1)*length(nodes)) + 1 	# select random index
	nID <- names(nodes[x])
	edges <- removeVertexEdges(nID, edges)		# remove edges of the node
  }
  
  
  ############# step 2:  With probability b we delete k randomly chosen edges ############
  rnd <- runif(1)
  if(rnd < b && nrow(edges) > 0){
	j <- 0
	
	nonZeroEdges <- edges[edges$weight > 0,]				# get present edges (weight > 0)
	nbEdgesToDelete <- min(c(k, nrow(nonZeroEdges)))		# number of edges to delete
	
	while(j < nbEdgesToDelete){
		
		# select random index
		x <- as.integer(runif(1)*nrow(nonZeroEdges)) + 1 	
		
		# set weight to zero (delete the edge but keep the node)
		df1 <- nonZeroEdges[x,]
		df1[,3] <- 0								
		
		# update list of edges back
		edges <- merge(edges, df1, by = c("src", "target"), all.x = TRUE)	
		edges <- transform(edges, weight = ifelse(is.na(weight.y), weight.x, weight.y))[-(3:4)]
		
		# update nonZeroEdges for next iteration
		nonZeroEdges <- edges[edges$weight > 0,]
		j <- j + 1
	}
	
  }
  
  nodes <- updateNodes(edges)				# update nodes list
  
  ############# step 3:  With probability a we add a vertex x to the graph. We then add k random edges incident with x ############
  rnd <- runif(1)
  if(rnd < a){
    sumDegree <- graphDegree(nodes)
	neighborLst <- list()		# list to store current neighbors to avoid redundancy
	
	# choose new random node name
	namesAvailable <- setdiff(allNodesNames,usedNames)  # usednames store all names used so far to avoid reusing deleted vertices
	newID <- as.integer(sample(namesAvailable, 1))
	
	# connect the new node to k nodes already exist in the graph based on probability: (deg(i))/Sum(deg(i))
	j <- 1
	nodesAvailable <- setdiff(names(nodes), neighborLst)		# dont consider already connected nodes
	nbIncidentEdges <- min(c(k, length(nodesAvailable)))		# number of incident edges from the new added node
	
	while (j <= nbIncidentEdges) {
		
		x <- as.integer(runif(1)*length(nodesAvailable))+1 	# select random index
		
		nodeId 	<- nodesAvailable[x]
		nodeDeg <- nodes[[nodeId]]
		p <- (nodeDeg+1) / sumDegree					# preferential attachment
		
		if(runif(1) < p){	
			
			# add link
			edges[nrow(edges) + 1,] = list(newID, strtoi(nodeId), defaultEdgeWeight)

			# update nodeId to neighborLst to avoid redundancy at the same timepoint
			neighborLst[j] <- nodeId
			nodesAvailable <- setdiff(names(nodes), neighborLst)	# update nodesAvailable list
			j <- j+1
		}
		
	} 
	
	if(nbIncidentEdges == 0)	# if the graph is empty, add self connecting edge with weight 0
		edges[nrow(edges) + 1,] = list(newID, newID, 0)	
	
	usedNames[length(usedNames)+1] <- as.character(newID)
	nodes <- updateNodes(edges)				# update nodes list  
  }
  
  
  
  
  
  ############# step 4: With probability s we add k random edges to existing vertices. Both endpoints are chosen independently by preferential attachment ###############
  rnd <- runif(1)
  if(rnd < s && length(nodes) > 1){
		sumDegree <- graphDegree(nodes)
	
		# get nonzero weight edges
		nonZeroEdges <- edges[edges$weight > 0,]							
		
		# switch src and target columns
		nonZeroEdgesSwitched <- data.frame(src = nonZeroEdges[,2], target = nonZeroEdges[,1], weight = nonZeroEdges[,3])			
		
		# get list of all possible edges in the graph
		xt <- aperm(combn(names(nodes),2)) 
		edgesAvailable <- paste(xt[,1], xt[,2]) 		
		
		
		
		# filter the list by removing already existing edges
		nonZeroEdges <- paste(nonZeroEdges[,1], nonZeroEdges[,2])
		nonZeroEdgesSwitched <- paste(nonZeroEdgesSwitched[,1], nonZeroEdgesSwitched[,2])
		
		edgesAvailable <- setdiff(setdiff(edgesAvailable, nonZeroEdges), nonZeroEdgesSwitched)
		
		j <- 1
		nbEdgesToAdd <- min(c(k, length(edgesAvailable)))					# number of edges to add
		if(nbEdgesToAdd > 0){
			
			while (j <= nbEdgesToAdd) {
			
				x <- as.integer(runif(1)*length(edgesAvailable))+1 			# select random src node
				
				
				e <- unlist(strsplit(edgesAvailable[x], " "))
				
				srcNodeId  <-  e[1]
				srcNodeDeg <- nodes[[srcNodeId]]
				pSrc <- (srcNodeDeg+1) / sumDegree							# preferential attachment of src node
				
				targetNodeId <-  e[2]
				targetNodeDeg <- nodes[[targetNodeId]]
				pTarget <- (targetNodeDeg+1) / sumDegree					# preferential attachment of target node
				
				if(runif(1) < pSrc && runif(1) < pTarget){	
					
					# add link
					edges[nrow(edges) + 1,] = list(srcNodeId, targetNodeId, defaultEdgeWeight)
				
					edgesAvailable <- edgesAvailable[-c(x)]			# update edgesAvailable list
					j <- j + 1
				}
				
				
			}
			
			nodes <- updateNodes(edges)				# update nodes list
		}
	
	
  }
  
  nonZeroEdges <- edges[edges$weight > 0,]
  nbEdges <- nrow(nonZeroEdges)				
  nbNodes <- length(nodes)
  
  densities[i] <- if(nbNodes > 0)(nbEdges/nbNodes) else 0
  
  
  ##################### write edges of the current timepoint to the csv file ############################
	
	if(nrow(nonZeroEdges)>0){
		df1 <- data.frame(timepoint = i, src = as.integer(nonZeroEdges[,1]), target = as.integer(nonZeroEdges[,2]), weight= as.double(nonZeroEdges[,3]))
		fileBuffer <- rbind(fileBuffer, df1)
		
		df2 <- data.frame(src = as.integer(nonZeroEdges[,1]), target = as.integer(nonZeroEdges[,2]), time = i, weight= as.double(nonZeroEdges[,3]))
		allEdges <- rbind(allEdges, df2)
		
		if(nrow(fileBuffer) > bufferSize){
			write.table(fileBuffer, file = csvFileName , sep = ",", col.names = !file.exists(csvFileName), row.names=FALSE, append = TRUE)
			fileBuffer <- fileBuffer[0, ]	#empty fileBuffer
		}
	}
	
	
  
  
  
  
}

# write last chunck of the fileBuffer
if(nrow(fileBuffer) > 0){
	write.table(fileBuffer, file = csvFileName , sep = ",", col.names = !file.exists(csvFileName), row.names=FALSE, append = TRUE)
	fileBuffer <- fileBuffer[0, ]	#empty fileBuffer
}



# save the used parameters
fileConn<-file(txtFileName)
param1 <- paste('avgDensity:',mean(densities))
param2 <- paste('totalNodes:',length(usedNames))
param3 <- paste('timepoints:',timepoints)
param4 <- paste('k:',k)
param5 <- paste('alpha:',alpha)
param6 <- paste('alpha0:',alpha0)
param7 <- paste('alpha1:',alpha1)

writeLines(c(param1,param2,param3,param4,param5,param6,param7), fileConn)
close(fileConn)

print(densities)
print(paste('avgDensity:',mean(densities)))
print(paste('totalNodes:',length(usedNames)))



######################################## plot smallmultiples #############################################


#generate the full graph
g <- graph.data.frame(allEdges,directed=F)

#generate a cool palette for the graph (darker colors = older nodes)
#YlOrBr.pal <- colorRampPalette(brewer.pal(8,"YlOrRd"))
#colors for the nodes are chosen from the very beginning
#V(g)$color <- rev(YlOrBr.pal(vcount(g)))[as.numeric(V(g)$name)]

#time in the edges goes from 1 to 300. We kick off at time 3
ti <- 1
#remove edges which are not present
gt <- delete_edges(g,which(E(g)$time != ti))
#generate first layout using graphopt with normalized coordinates. This places the initially connected set of nodes in the middle. If you use fruchterman.reingold it will place that initial set in the outer ring.
layout.old <- norm_coords(layout.graphopt(gt), xmin = -1, xmax = 1, ymin = -1, ymax = 1)

#total time of the dynamics
total_time <- max(E(g)$time)
#This is the time interval for the animation. In this case is taken to be 1/10
#of the time (i.e. 10 snapshots) between adding two consecutive nodes
dt <- 1
#Output for each frame will be a png with HD size 1600x900 :)
#png(file="smallmultiples/out/time%03d.png", width=1600,height=900)

g_per_row = 4
rows <- round(total_time/g_per_row + 1)
svg(filename=svgFileName, width = 18, height = timepoints, pointsize=12)
par(mfrow=c(rows,g_per_row),mar=c(1.5,1.5,2,1.5), oma=c(0,0,0,0))

#Time loop starts
for(time in seq(ti,total_time,dt)){
  
  x <- floor(time)
  
  #remove edges which are not present
  gt <- delete_edges(g,which(E(g)$time !=  x))
  
  if(length(E(gt)) > 0){
    #with the new graph, we update the layout a little bit
    layout.new <- layout_with_fr(gt,coords=layout.old,niter=10,start.temp=0.05,grid="nogrid")
    
    
    
    #plot the new graph
    plot(gt,layout=layout.new,
         vertex.size=ifelse(degree(gt)>0,2,1+2*log(degree(gt))),
         vertex.frame.color=V(g)$color,edge.width=1.5,
         asp=9/16,margin=-0.15,
         #vertex.label=NA
         vertex.label.dist=1, vertex.label.degree=-pi/2,
         main = paste("time_",x, sep="")
    )
    
    
    #use the new layout in the next round
    #use the new layout in the next round
    layout.old <- layout.new
  }else{
    plot.new()
  }
  
}
dev.off()

# ###################################### plot graph at last timepoint #####################################
# g <- barabasi.game(newID - 1, power = 1.3, m =k, directed=TRUE) #matrix(0, nrow=n, ncol=n)
# g[,] <- 0
# nonZeroEdges <- edges[edges$weight > 0,]				# get present edges (weight > 0)
# i <- 1
# while(i <= nrow(nonZeroEdges)){
#   src <- nonZeroEdges[i,1]
#   target <- nonZeroEdges[i,2]
#   g[src,target] <- nonZeroEdges[i,3]
#   i <- i+1
# }
# 
# plot(g, vertex.label= NA, edge.arrow.size=0.02,vertex.size = 0.5, xlab = "Scale-free network model")


