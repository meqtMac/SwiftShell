//
//  File.swift
//
//
//  Created by 蒋艺 on 2023/8/26.
//

import Foundation

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

let ls = Process()
ls.executableURL = URL(fileURLWithPath: "/usr/bin/env")
ls.arguments = ["ls", "-al"]

var pipe = Pipe()

ls.standardOutput = pipe

let sort = Process()
//let completePipe = Pipe()

sort.executableURL = URL(fileURLWithPath: "/usr/bin/env")
sort.arguments = ["sort"]
sort.standardInput = pipe
//sort.standardOutput = completePipe

infix operator =>
func => (lhs: Process, rhs: Process) -> Process {
    let pipe = Pipe()
    lhs.standardOutput = pipe
    rhs.standardInput = pipe
    try? lhs.run()
    return rhs
}

let vim = Process()
vim.executableURL = URL(filePath: "/usr/bin/env")
vim.arguments = ["vim", "~/Downloads/temp.swift"]
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
try vim.run()
