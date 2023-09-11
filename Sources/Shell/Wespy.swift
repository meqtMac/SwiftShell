//
//  File.swift
//  
//
//  Created by 蒋艺 on 2023/9/6.
//

import Foundation

public enum Wespy {
//    public var install
    /// pod install
    public enum InstallFlags: Hashable {
        case simulator
        case debug
        case flutter
        case debugFlugger
        case unity
        case verbose
        case app(name: String)
    }
    
    public static func install(with flags: Set<InstallFlags> = []) {
        let process = Process()
        process.executableURL = URL(fileURLWithPath: "/usr/bin/env")
        process.arguments = ["wp", "install"] + flags.map{ $0.flag }
        let pipe = Pipe()
        process.standardOutput = pipe
        try? process.run()
        process.waitUntilExit()
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        print(data)
//        return String(data: data, encoding: .utf8)!
    }
    
//    public var version: String {
//        let process = Process()
//        process.executableURL = URL(fileURLWithPath: "/usr/bin/env")
//        process.arguments = ["swift", "--version"]
//        let pipe = Pipe()
//        process.standardOutput = pipe
//        try? process.run()
//        process.waitUntilExit()
//        let data = pipe.fileHandleForReading.readDataToEndOfFile()
//        return String(data: data, encoding: .utf8)!
//    }
//    
//    public static func build() throws -> String {
//        let process = Process()
//        process.executableURL = URL(fileURLWithPath: "/usr/bin/env")
//        process.arguments = ["swift", "build"]
//        let pipe = Pipe()
//        process.standardOutput = pipe
//        try? process.run()
//        process.waitUntilExit()
//        let data = pipe.fileHandleForReading.readDataToEndOfFile()
//        return String(data: data, encoding: .utf8)!
//    }
//    
//    public static var help: String {
//        let process = Process()
//        process.executableURL = URL(fileURLWithPath: "/usr/bin/env")
//        process.arguments = ["swift", "--help"]
//        let pipe = Pipe()
//        process.standardOutput = pipe
//        try? process.run()
//        process.waitUntilExit()
//        let data = pipe.fileHandleForReading.readDataToEndOfFile()
//        return String(data: data, encoding: .utf8)!
//    }

}

extension Wespy.InstallFlags {
    var flag: String {
        switch self {
        case .simulator:
            return "--simulator"
        case .debug:
            return "--debug"
        case .flutter:
            return "--flutter"
        case .debugFlugger:
            return "--debugfltter"
        case .unity:
            return "--unity"
        case .verbose:
            return "--verbose"
        case let .app(name):
            return "--app \(name)"
        }
    }
}
