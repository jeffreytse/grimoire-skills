---
name: apply-graph-theory-analysis
description: Use when analyzing networks, relationships, or connectivity problems using graph theory — including graph representation, traversal algorithms, shortest path, minimum spanning tree, centrality measures, and community detection.
source: West "Introduction to Graph Theory" 2nd ed. (2001); Newman "Networks: An Introduction" (2010); Diestel "Graph Theory" 5th ed. (2017, free online); NetworkX documentation (Hagberg et al., 2008)
tags: [graph-theory, network-analysis, shortest-path, centrality, algorithms, combinatorics, data-structures]
---

# Apply Graph Theory Analysis

Represent and analyze networks using graph theory — selecting appropriate graph models, applying correct traversal and search algorithms, computing centrality and connectivity metrics, and detecting community structure to answer structural questions about the network.

## Why This Is Best Practice

**Adopted by:** Google (PageRank = eigenvector centrality of the web graph), social network analysis (Facebook, LinkedIn graph algorithms), logistics (UPS/FedEx routing = shortest path on road networks), computational biology (protein interaction networks, metabolic pathways), and electrical engineering (circuit analysis = Kirchhoff's laws on a graph). NetworkX (Python) and igraph (R/Python/C) are the dominant open-source graph analysis libraries.
**Impact:** Newman (2010) established the theoretical foundations of network science — demonstrating that most real networks have scale-free degree distributions (hubs), small-world properties (short paths despite large size), and community structure. These properties determine resilience, information spread, and vulnerability in ways that aggregate statistics miss entirely. The PageRank algorithm (Brin & Page, 1998) — a specialization of eigenvector centrality — generates ~$140B+ annual revenue for Google by identifying authoritative web pages.

## Steps

### 1. Choose the correct graph representation

Define the graph type based on the problem:
- **Undirected graph G = (V, E):** edges have no direction; friendship networks, road networks (bidirectional)
- **Directed graph (digraph) G = (V, E):** edges have direction; web links, citation networks, supply chains
- **Weighted graph:** each edge has a weight (distance, capacity, cost); required for shortest path problems
- **Bipartite graph:** vertices split into two disjoint sets with edges only between sets; user-item interactions, job-worker assignment
- **Multigraph:** multiple edges between the same pair of vertices; airline routes with multiple flights

```python
import networkx as nx
G = nx.Graph()          # undirected, unweighted
G = nx.DiGraph()        # directed
G = nx.Graph()
G.add_edge('A', 'B', weight=5.0)
```

### 2. Analyze basic graph properties

Compute structural metrics before any algorithm:
```python
n = G.number_of_nodes()     # |V|
m = G.number_of_edges()     # |E|
density = nx.density(G)     # 2m / n(n-1) for undirected
is_connected = nx.is_connected(G)       # for undirected
is_strongly = nx.is_strongly_connected(G)  # for directed (all pairs reachable)

# Degree distribution
degrees = [d for n, d in G.degree()]
avg_degree = sum(degrees) / len(degrees)
```

Degree distribution shape:
- Normal → random network
- Power law (many low-degree, few hubs) → scale-free network (most real-world networks)

### 3. Apply traversal and search algorithms

**Breadth-First Search (BFS):** finds shortest path in unweighted graphs; explores level by level
```python
# Shortest path in unweighted graph (BFS-based)
path = nx.shortest_path(G, source='A', target='B')
length = nx.shortest_path_length(G, source='A', target='B')
```

**Depth-First Search (DFS):** explores as deep as possible; used for cycle detection, topological sort, connected components

**For weighted graphs — Dijkstra's algorithm:**
```python
path = nx.shortest_path(G, source='A', target='B', weight='weight')
length = nx.shortest_path_length(G, source='A', target='B', weight='weight')
# O(E log V); requires non-negative weights
```

**For negative weights — Bellman-Ford:**
```python
path = nx.bellman_ford_path(G, source='A', target='B', weight='weight')
# O(VE); handles negative edges; detects negative cycles
```

### 4. Compute centrality measures

Select centrality metric based on what "importance" means in context:
| Centrality | Measures | Best for |
|-----------|---------|----------|
| Degree centrality | Number of connections | Local popularity |
| Betweenness centrality | Fraction of shortest paths through v | Bridge/bottleneck nodes |
| Closeness centrality | Average distance to all other nodes | Broadcast efficiency |
| Eigenvector centrality | Influence accounting for neighbor influence | Authority (PageRank variant) |
| PageRank | Directed version of eigenvector | Web ranking, citation impact |

```python
bc = nx.betweenness_centrality(G)       # normalized by default
pr = nx.pagerank(G, alpha=0.85)         # damping factor 0.85 = Google's original
ec = nx.eigenvector_centrality(G)
```

### 5. Find minimum spanning tree and connectivity

**Minimum spanning tree (MST):** connect all nodes with minimum total edge weight
```python
# Kruskal's algorithm (good for sparse graphs)
mst = nx.minimum_spanning_tree(G, weight='weight', algorithm='kruskal')
# Prim's algorithm (good for dense graphs): algorithm='prim'
total_weight = mst.size(weight='weight')
```

**Connectivity:**
```python
# Cut vertices (removing disconnects the graph)
cut_vertices = list(nx.articulation_points(G))
# Bridges (removing disconnects an edge)
bridges = list(nx.bridges(G))
# Minimum vertex cut (fewest vertices to remove to disconnect)
min_cut = nx.minimum_node_cut(G, s, t)
```

### 6. Detect communities

Community detection identifies groups of densely connected nodes:
```python
from networkx.algorithms import community

# Louvain algorithm (fast, widely used)
# install: pip install python-louvain
import community as community_louvain
partition = community_louvain.best_partition(G)
modularity = community_louvain.modularity(partition, G)

# Girvan-Newman (hierarchical, slower)
communities = community.girvan_newman(G)
```

Modularity Q: ranges from 0 to 1; Q > 0.3 indicates meaningful community structure.

## Common Mistakes

- **Choosing undirected when directed matters:** Web links, citations, and supply chains are directed — using undirected loses all directional information and produces wrong centrality, reachability, and path results.
- **Using Dijkstra on a graph with negative edge weights:** Dijkstra's algorithm produces incorrect results with negative weights. Use Bellman-Ford or Johnson's algorithm.
- **Computing all-pairs shortest paths on large graphs:** Floyd-Warshall is O(V³) — on a 10,000-node network this is 10¹² operations. Use BFS/Dijkstra from a sample of source nodes for large graphs.

## When NOT to Use

- Hypergraph problems (edges connect >2 nodes simultaneously, e.g., collaboration groups): standard graph models force artificial pairwise decomposition; use hypergraph libraries (HyperNetX) or simplicial complexes instead.
