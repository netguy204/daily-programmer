#include "common.h"

#include <iostream>
#include <cassert>

#include "Graph.h"
#include "Node.h"
#include "Edge.h"

using namespace std;

int main(int argc, char ** argv) {
  GC_INIT();
  GC_enable_incremental();

  Graph graph;
  Node * one = graph.addNode(new Node("one"));
  Node * two = graph.addNode(new Node("two"));

  assert(one == graph.findNode("one"));
  assert(two == graph.findNode("two"));

  graph.addEdge(new Edge(one, two));

  BOOST_AUTO(nodes, graph.nodesFrom(one));
  assert(nodes.size() == 1);
  assert(two == *(nodes.begin()));
}
