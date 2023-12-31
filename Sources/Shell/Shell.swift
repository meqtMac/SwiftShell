import Foundation
//import Darwin

public func ls() throws -> String {
    let process = Process()
    process.executableURL = URL(fileURLWithPath: "/usr/bin/env")
    process.arguments = ["ls", "-al"]
    let pipe = Pipe()
    process.standardOutput = pipe
    try process.run()
    process.waitUntilExit()
    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    return String(data: data, encoding: .utf8)!
}

public func exit(_ n: Int32 = 0) {
    Foundation.exit(n)
}

public var pwd: String {
    FileManager.default.currentDirectoryPath
}

prefix operator =>
public prefix func =>(_ path: String) throws {
    FileManager.default.changeCurrentDirectoryPath(path)
}

public func clear() {
    print("\u{001B}[2J\u{001B}[;H")
}

public enum Swift {
    static let command = "swift"
    
    public static var version: String {
        runCmd(executableURLPath: envPath, command: Self.command, options: ["--version"])
    }
    
    public static func build() {
//        print( runCmd(executableURLPath: envPath, command: Self.command, options: ["build"]) )
        runCommand(executableURLPath: envPath, command: Self.command, options: ["build"])
    }
    
    public static var help: String {
        runCmd(executableURLPath: envPath, command: Self.command, options: ["--help"])
    }
    
    public static func repl() {
        runCommand(executableURLPath: envPath, command: Self.command, options: ["repl"])
    }
    
    public static func run() {
        runCommand(executableURLPath: envPath, command: Self.command, options: ["run"])
    }
}


