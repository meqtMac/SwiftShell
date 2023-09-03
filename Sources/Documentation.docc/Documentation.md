# Swift Shell

<!--@START_MENU_TOKEN@-->Summary<!--@END_MENU_TOKEN@-->

## Overview

<!--@START_MENU_TOKEN@-->Text<!--@END_MENU_TOKEN@-->

## Topics

### <!--@START_MENU_TOKEN@-->Group<!--@END_MENU_TOKEN@-->

- <!--@START_MENU_TOKEN@-->``Symbol``<!--@END_MENU_TOKEN@-->

``` swift
@resultBuilder
    struct FlagBuilder

ls(@FlagBuilder flags: () -> Flags ) 
struct Command {

    static func run()
    enum Flags {
        case list,
        case hidden,
        case name(Paths: String... or Regex)
    }
    subcommands that are command
}

call with:

ls {
    .list
    .hidden
    .name()
}
```
