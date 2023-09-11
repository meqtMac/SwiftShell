//
//  File.swift
//
//
//  Created by 蒋艺 on 2023/8/26.
//

//import Foundation

//func ls() {
//    let process = Process()
//    process.executableURL = URL(filePath: "/usr/bin/env")
//    process.arguments = ["ls", "-al"]
//    process.waitUntilExit()
//    do {
//        try process.run()
//    } catch {
//        //
//    }
//}

//let ls = Process()
//ls.executableURL = URL(fileURLWithPath: "/usr/bin/env")
//ls.arguments = ["ls", "-al"]

//var pipe = Pipe()

//ls.standardOutput = pipe

//let sort = Process()
//let completePipe = Pipe()

//sort.executableURL = URL(fileURLWithPath: "/usr/bin/env")
//sort.arguments = ["sort"]
//sort.standardInput = pipe
//sort.standardOutput = completePipe

//infix operator =>
//func => (lhs: Process, rhs: Process) -> Process {
//    let pipe = Pipe()
//    lhs.standardOutput = pipe
//    rhs.standardInput = pipe
//    try? lhs.run()
//    return rhs
//}
//
//let vim = Process()
//vim.executableURL = URL(filePath: "/usr/bin/env")
//vim.arguments = ["vim", "~/Downloads/temp.swift"]
//let stdOut = FileHandle.withStandardOutput

//do{
//    try ls.run()
//    try sort.run()
//    let data = completePipe.fileHandleForReading.readDataToEndOfFile()
//    if let output = String(data: data, encoding: String.Encoding.utf8) {
//        print(output)
//    }
//} catch {
//    
//}
//ls.waitUntilExit()
//sort.waitUntilExit()
//try (ls => sort).run()

//try ls.run()
//try sort.run()
//try vim.run()

import Foundation

// Define a structure to represent an edge
struct Edge {
    let from: Int
    let to: Int
}

// Function to read and process the file
func readAndProcessFile(fileName: String) {
    if let fileURL = URL(fileURLWithPath: fileName)// Bundle.main.url(forResource: fileName, withExtension: "txt") {
    {
        do {
            // Read the file content as a string
            let fileContents = try String(contentsOf: fileURL, encoding: .utf8)
            
            // Split the content into lines
            let lines = fileContents.components(separatedBy: .newlines)
            
            // Ensure there are at least two lines
            guard lines.count >= 2, let numVertices = Int(lines[0]), let numEdges = Int(lines[1]) else {
                print("Invalid input format.")
                return
            }
            
            // Create an array to store the edges
            var edges = [Edge]()
            
            // Process the lines starting from the third line (index 2)
            for i in 2..<lines.count {
                let components = lines[i].components(separatedBy: .whitespaces)
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
                print("\(edge.from) -> \(edge.to)")
            }
            
            // Now, you have the vertices, edges, and edge data in the 'edges' array. You can perform further processing as needed.
            
        } catch {
            print("Error reading the file: \(error)")
        }
    } else {
        print("File not found.")
    }
}

// Call the function with your file name
let fileName = "input"
readAndProcessFile(fileName: fileName)
