import Foundation
let fileURL = URL(fileURLWithPath: "tinyDG.txt")
let fileContents = try String(contentsOf: fileURL, encoding: .utf8)

let lines = fileContents.components(separatedBy: .newlines)

// Ensure there are at least two lines
guard lines.count >= 2, let numVertices = Int(lines[0]), let numEdges = Int(lines[1]) else {
    print("Invalid input format.")
    fatalError()
//    return
}

struct Edge {
    let from: Int
    let to: Int
}
// Create an array to store the edges
var edges = [Edge]()

// Process the lines starting from the third line (index 2)
for i in 2..<lines.count {
    let components = lines[i].components(separatedBy: .whitespaces).filter { !$0.isEmpty }
    print(i, lines[i], components)
    if components.count == 2, let from = Int(components[0]), let to = Int(components[1]) {
        let edge = Edge(from: from, to: to)
        edges.append(edge)
    }
}

// Print the number of vertices and edges
print("Number of vertices: \(numVertices)")
print("Number of edges: \(numEdges)")
    
// Print the processed edges
for edge in edges {
    print("graph.addEdge(from: \(edge.from), to: \(edge.to))")
}

print(fileContents)

 
