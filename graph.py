#!/usr/bin/env python

import pygraphviz as pgv
import sys

#   origin_dest :: String -> Maybe (String, String)
def origin_dest(line):
    split_line = line.split(' ', 1)
    if len(split_line) > 1:
        origin, dest = split_line
        if "state" in origin and "state" in dest:
            return (origin, dest)
        else:
            return None
    else:
        return None

def main():
    file_name = sys.argv[1]
    graph = pgv.AGraph(strict=False, directed=True)
    graph.graph_attr['label'] = file_name
    step = 0
    for line in sys.stdin:
        line = line.strip()
        if origin_dest(line) != None:
            origin, dest = origin_dest(line)
            graph.add_edge(origin, dest, label=str(step))
            step += 1
    graph.layout(prog='dot')
    graph.draw(file_name+".png")

if __name__ == "__main__":
    main()
