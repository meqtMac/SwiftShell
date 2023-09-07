//
//  File.swift
//  
//
//  Created by 蒋艺 on 2023/9/6.
//

import Foundation

public enum Git {
    private static let command = "git"
    /// Represents various options for the `git status` command.
    public enum StatusOption {
        /// Give the output in the short-format.
        case short
        
        /// Show the branch and tracking info even in short-format.
        case branch
        
        /// Show the number of entries currently stashed away.
        case showStash
        
        /// Give the output in an easy-to-parse format for scripts.
        /// This is similar to the short output but will remain stable across Git versions
        /// and regardless of user configuration.
        ///
        /// - Parameter version: The format version (optional, defaults to the original version v1 format).
        case porcelain(version: String?)
        
        /// Give the output in the long-format (default).
        case long
        
        /// In addition to the names of files that have been changed,
        /// also show the textual changes that are staged to be committed.
        /// If specified twice, then also show the changes in the working tree that have not yet been staged.
        case verbose
        
        /// Show untracked files.
        ///
        /// - Parameter mode: The handling of untracked files.
        ///   - `.no`: Show no untracked files.
        ///   - `.normal`: Shows untracked files and directories.
        ///   - `.all`: Also shows individual files in untracked directories.
        case untrackedFiles(mode: UntrackedFileMode)
        
        /// Ignore changes to submodules when looking for changes.
        ///
        /// - Parameter submoduleHandling: Handling of submodules.
        ///   - `.none`: Consider the submodule modified when it contains untracked or modified files
        ///              or its HEAD differs from the commit recorded in the superproject.
        ///   - `.untracked`: Submodules are not considered dirty when they only contain untracked content
        ///                   (but they are still scanned for modified content).
        ///   - `.dirty`: Ignores all changes to the work tree of submodules.
        ///   - `.all`: Hides all changes to submodules.
        case ignoreSubmodules(submoduleHandling: SubmoduleHandling)
        
        /// Show ignored files as well.
        ///
        /// - Parameter ignoredHandling: Handling of ignored files.
        ///   - `.traditional`: Shows ignored files and directories, unless `--untracked-files=all` is specified,
        ///                     in which case individual files in ignored directories are displayed.
        ///   - `.no`: Show no ignored files.
        ///   - `.matching`: Shows ignored files and directories matching an ignore pattern.
        case ignoredFiles(ignoredHandling: IgnoredFileHandling)
        
        /// Terminate entries with NUL, instead of LF.
        /// This implies the `--porcelain=v1` output format if no other format is given.
        case terminateWithNull
        
        /// Display untracked files in columns.
        ///
        /// - Parameter columnOptions: Option syntax for displaying untracked files in columns
        ///   (see configuration variable `column.status`).
        case displayUntrackedInColumns(columnOptions: String?)
        
        /// Display or do not display detailed ahead/behind counts for the branch relative to its upstream branch.
        ///
        /// - Parameter shouldDisplay: `true` to display ahead/behind counts (default), `false` otherwise.
        case displayAheadBehindCounts(shouldDisplay: Bool)
        
        /// Turn on/off rename detection regardless of user configuration.
        ///
        /// - Parameter shouldDetectRenames: `true` to enable rename detection, `false` to disable it.
        case renameDetection(shouldDetectRenames: Bool)
        
        /// Turn on rename detection, optionally setting the similarity threshold.
        ///
        /// - Parameter similarityThreshold: The similarity threshold for rename detection (optional).
        case findRenames(similarityThreshold: Int?)
        
        /// Handling modes for untracked files.
        public enum UntrackedFileMode {
            /// Show no untracked files.
            case no
            
            /// Shows untracked files and directories.
            case normal
            
            /// Also shows individual files in untracked directories.
            case all
        }
        
        /// Handling modes for submodules.
        public enum SubmoduleHandling {
            /// Consider the submodule modified when it contains untracked or modified files
            /// or its HEAD differs from the commit recorded in the superproject.
            case none
            
            /// Submodules are not considered dirty when they only contain untracked content
            /// (but they are still scanned for modified content).
            case untracked
            
            /// Ignores all changes to the work tree of submodules.
            case dirty
            
            /// Hides all changes to submodules.
            case all
        }
        
        /// Handling modes for ignored files.
        public enum IgnoredFileHandling {
            /// Shows ignored files and directories, unless `--untracked-files=all` is specified,
            /// in which case individual files in ignored directories are displayed.
            case traditional
            
            /// Show no ignored files.
            case no
            
            /// Shows ignored files and directories matching an ignore pattern.
            case matching
        }
    }
   
    public static func status() {
        runCommand(executableURLPath: envPath, command: command, options: ["status"])
    }
    
    public static func fetch() {
        runCommand(executableURLPath: envPath, command: command, options: ["fetch"])
    }
    
    
    /// Represents various options for the `git clone` command.
    public enum CloneOption {
        /// The URL of the Git repository to clone.
        case repositoryURL(String)
        
        /// The branch to clone (optional).
        case branch(String)
        
        case directory(String)
        
        /// Construct the `git clone` command based on the options and execute it.
        ///
        /// - Parameter envPath: The path to the Git executable.
        /// - Returns: The result of the `git clone` command.
        var option: String {
            switch self {
            case let .repositoryURL(url):
                return "\(url)"
            case let .branch(branch):
                return "--branch \(branch)"
            case let .directory(directory):
                return "\(directory)"
           }
        }
    }
    
    public static func clone(branch: String = "", repo: String, directory: String = "" ) {
        var options: [CloneOption] = []
        if !branch.isEmpty {
            options.append(.branch(branch))
        }
        options.append(.repositoryURL(repo))
        if !directory.isEmpty {
            options.append(.directory(directory))
        }
        runCommand(executableURLPath: "/usr/bin/git", command: "clone", options: options.map { $0.option } )
    }
    
//    public static func log() {
//        runCommand(executableURLPath: "/usr/bin/git", command: "log", options: [] )
//    }
}
