//
//  File.swift
//  
//
//  Created by 蒋艺 on 2023/9/6.
//

import Foundation

func runCmd(executableURLPath: String, command: String, options: Set<String> ) -> String {
    let process = Process()
    process.executableURL = URL(fileURLWithPath: executableURLPath)
    process.arguments = [command] + [String](options)
    let pipe = Pipe()
    process.standardOutput = pipe
    try? process.run()
    process.waitUntilExit()
    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    return String(data: data, encoding: .utf8)!
}

func runCommand(executableURLPath: String, command: String, options: [String] ) {
        let process = Process()
        process.executableURL = URL(filePath: executableURLPath)
        process.arguments = [command] + options
        let pipe = Pipe()
        process.standardOutput = pipe
        
        pipe.fileHandleForReading.readabilityHandler = { handle in
            let availableData = handle.availableData
            if let outputString = String(data: availableData, encoding: .utf8) {
                print(outputString, terminator: "")
            }
        }
        
        do {
            try process.run()
            process.waitUntilExit()
            try pipe.fileHandleForReading.close()
        } catch {
            print("Error: \(error)")
        }
    }

let envPath = "usr/bin/env"

