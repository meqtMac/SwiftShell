import Foundation
let lines = 
"""
warning: 'swiftshell': /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/swift-frontend 
-frontend
-c
-primary-file /Users/meqt/Developer/Swift/SwiftShell/Package.swift
-target arm64-apple-macosx12.0
-Xllvm
-aarch64-use-tbi
-enable-objc-interop
-stack-check
-sdk /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX13.3.sdk
-I /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/usr/lib
-I /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/swift/pm/ManifestAPI
-F /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/Library/Frameworks 
-vfsoverlay /var/folders/_x/93nl31qn03zdl7gp4vbm5v3w0000gn/T/TemporaryDirectory.MmUXVW/vfs.yaml
-swift-version 5
-package-description-version 5.8.0
-new-driver-path /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/swift-driver
-disable-implicit-concurrency-module-import
-disable-implicit-string-processing-module-import
-empty-abi-descriptor
-resource-dir /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/swift
-module-name main
-disable-clang-spi
-target-sdk-version 13.3
-target-sdk-name macosx13.3
-o /var/folders/_x/93nl31qn03zdl7gp4vbm5v3w0000gn/T/TemporaryDirectory.v6aRZC/Package-1.o

/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang /var/folders/_x/93nl31qn03zdl7gp4vbm5v3w0000gn/T/TemporaryDirectory.v6aRZC/Package-1.o 
-F /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/Library/Frameworks
--sysroot /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX13.3.sdk
-lSystem
--target=arm64-apple-macosx12.0
-force_load /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/swift/macosx/libswiftCompatibility56.a 
-L /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/swift/macosx
-L /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX13.3.sdk/usr/lib/swift
-L /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/swift/pm/ManifestAPI
-L /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/usr/lib
-lPackageDescription
-Xlinker
-rpath
-Xlinker /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/swift/pm/ManifestAPI
-o /var/folders/_x/93nl31qn03zdl7gp4vbm5v3w0000gn/T/TemporaryDirectory.l69fup/swiftshell-manifest
Apple Swift version 5.8.1 (swiftlang-5.8.0.124.5 clang-1403.0.22.11.100)
Target: arm64-apple-macosx12.0
error: no executable product available
"""
print(
    lines.split(separator: " ").joined(separator: "\n")
)
