#import "@preview/ilm:1.4.1": *
#import "@preview/physica:0.9.5": *
#import "@preview/thmbox:0.2.0": *
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge, shapes

#show: thmbox-init(counter-level: 2)
#set text(lang: "en")
#set figure(numbering: none)

#let definition-counter = counter("definition")
#show: sectioned-counter(definition-counter, level: 2)
#let definition = definition.with(counter: definition-counter)

#show: ilm.with(
  title: [Operations Research],
  author: "Pooja Bansal",
  abstract: [],
)

= Network Flow Problem

#set text(font: "IosevkaTerm NFP")

#definition[Network][
  A network is described as $G=(N, L)$, where $N$ is the set of nodes and $L subset.eq N times N$ is the set of directed arcs/links.
  $ L = {(i, j) in N times N | "there is a directed arc from node i to j"} $
]
Consider $N = {1, 2, 3, 4, 5}$ and $L = {(1,2), (1,3), (1, 4), (2, 3), (3,5), (4, 3), (4, 5), (5, 4)}$,

#let nodes = ("1", "2", "3", "4", "5")
#let edges = (
  (0, 1), (0, 2), (0, 3), (1, 2), (2, 4), (3, 2), (3, 4), (4, 3)
)
#figure(
  diagram({
    for (i, n) in nodes.enumerate() {
      let θ = 90deg - i*360deg/nodes.len()
      node((θ, 18mm), n, stroke: 0.5pt, name: str(i))
    }
    for (from, to) in edges {
      let bend = if (to, from) in edges { 10deg } else { 0deg }
      // refer to nodes by label, e.g., <1>
      edge(label(str(from)), label(str(to)), "-|>", bend: bend)
    }
  }),
  caption: [Example Network]
)

#definition[Directed Link][
  A link is said to be directed if it allows positive flow in one direction and zero flow in the other direction. E.g. $3 arrow 5$.
]
#definition[Undirected Link][
  A link is said to be directed if it allows flow in both directions. E.g. $4 arrow 5$.
]
#definition[Directed Network][
  A network is said to be directed if all its links are directed.
]
#definition[Undirected Network][
  A network is said to be undirected if it contains a mixture of directed and undirected links.
]
The above example is an undirected network.
#definition[Path][
  A path is a sequence of distinct links that join any two nodes through some other nodes. E.g. $1 arrow 2 arrow 3$.
]
#definition[Directed Path][
  A directed path from node $i$ to node $j$ is a sequence of connected links having flow towards $j$. E.g. $1 arrow 2 arrow 3$.
]
#definition[Undirected Path][
  An undirected path may allow flow in either direction. E.g. $3 arrow 1 arrow 4$.
]
#definition[Cycle][
  A path is said to be a cycle if it connects a node to itself through some other nodes.
]
A directed cycle is $4 arrow 5 arrow 4$. An undirected cycle is $1 arrow 3 arrow 5 arrow 4 arrow 1$.
#definition[Connected Network][
  A network where every pair of distinct nodes is connected by at least one path.
]
#definition[Tree][
  A tree is a connected network that may involve only a subset of all the nodes of the network without having any cycle in between.
]
If a tree has $n$ nodes, then it will have $n-1$ links.
#definition[Spanning Tree][
  A tree that links all the nodes of a network.
]
