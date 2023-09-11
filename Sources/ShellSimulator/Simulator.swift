//
//  File.swift
//
//
//  Created by 蒋艺 on 2023/6/11.
//

import Foundation

struct MyShell{
    let prompt: ShellPrompt = ShellPrompt {
        ShellPrompt.PromptComponent.user
        ":"
        ShellPrompt.PromptComponent.lastPathComponent
        " $ "
    }
    let filemanager = FileManager.default
    func main() {
        printAllXtermColors()
        while true {
            print(prompt.drawPrompt(at: self), terminator: "")
            if let cmd = readLine(strippingNewline: false) {
                print("You entered cmd: \(cmd)")
            }else{
                print("Failed to receive anything.")
            }
        }
    }
}

@resultBuilder
struct PromptBuilder {
    typealias Component = ShellPrompt.PromptComponent
    static func buildBlock(_ components: Component...) -> [Component] {
        return components
    }
    static func buildExpression(_ expression: Component) -> Component {
        return expression
    }
    static func buildExpression(_ expression: Character) -> Component {
        ShellPrompt.PromptComponent.character(expression)
    }
    static func buildExpression(_ expression: String) -> Component {
        ShellPrompt.PromptComponent.string(expression)
    }
    static func buildArray(_ components: [Component]) -> [Component] {
        components
    }
}

struct ShellPrompt {
    var components: [PromptComponent]
    init(@PromptBuilder components: () -> [PromptComponent] ) {
        self.components = components()
    }
    func drawPrompt(at shell: MyShell) -> String {
        var promptString = ""
        for component in components {
            promptString += component.drawComponent(at: shell)
        }
        return promptString
    }
    
    enum PromptComponent {
        case user
        case path
        case lastPathComponent
        case character(Character)
        case string(String)
        
        func drawComponent(at shell: MyShell) -> String {
            switch self {
            case .user:
                return ANSI(color: .lightGreen, string: NSUserName())
            case .path:
                let path = shell.filemanager.currentDirectoryPath
                return ANSI(color: .backgroundCyan, string: path)
            case .lastPathComponent:
                var path = "/"
                if #available(macOS 13.0, *) {
                    path = URL(filePath: shell.filemanager.currentDirectoryPath).lastPathComponent
                }
                return ANSI(color: .cyan, string: path)
            case .character(let char):
                return ANSI(color: .cyan, string: String(char))
            case .string(let str):
                return ANSI(color: .blue, string: str)
            }
        }
    }
}

enum ANSIColor: String {
    case bold = "\u{001B}[1m"
    case dim = "\u{001B}[2m"
    case italic = "\u{001B}[3m"
    case underline = "\u{001B}[4m"
    case blink = "\u{001B}[5m"
    case inverse = "\u{001B}[7m"
    case hidden = "\u{001B}[8m"
    case strikethrough = "\u{001B}[9m"
    
    case black = "\u{001B}[30m"
    case red = "\u{001B}[31m"
    case green = "\u{001B}[32m"
    case yellow = "\u{001B}[33m"
    case blue = "\u{001B}[34m"
    case magenta = "\u{001B}[35m"
    case cyan = "\u{001B}[36m"
    case white = "\u{001B}[37m"
    case defaultColor = "\u{001B}[39m"
    case backgroundBlack = "\u{001B}[40m"
    case backgroundRed = "\u{001B}[41m"
    case backgroundGreen = "\u{001B}[42m"
    case backgroundYellow = "\u{001B}[43m"
    case backgroundBlue = "\u{001B}[44m"
    case backgroundMagenta = "\u{001B}[45m"
    case backgroundCyan = "\u{001B}[46m"
    case backgroundWhite = "\u{001B}[47m"
    case backgroundDefaultColor = "\u{001B}[49m"
    case lightBlack = "\u{001B}[90m"
    case lightRed = "\u{001B}[91m"
    case lightGreen = "\u{001B}[92m"
    case lightYellow = "\u{001B}[93m"
    case lightBlue = "\u{001B}[94m"
    case lightMagenta = "\u{001B}[95m"
    case lightCyan = "\u{001B}[96m"
    case lightWhite = "\u{001B}[97m"
    case backgroundLightBlack = "\u{001B}[100m"
    case backgroundLightRed = "\u{001B}[101m"
    case backgroundLightGreen = "\u{001B}[102m"
    case backgroundLightYellow = "\u{001B}[103m"
    case backgroundLightBlue = "\u{001B}[104m"
    case backgroundLightMagenta = "\u{001B}[105m"
    case backgroundLightCyan = "\u{001B}[106m"
    case backgroundLightWhite = "\u{001B}[107m"
    
    static var reset: String  {
        "\u{001B}[0m"
    }
}

enum XtermColor: CustomStringConvertible {
    case reset
    case bold
    case dim
    case italic
    case underline
    case blink
    case inverse
    case hidden
    case strikethrough
    case foregroundColor(Int)
    case backgroundColor(Int)
    
    var description: String {
        switch self {
        case .reset:
            return "\u{001B}[0m"
        case .bold:
            return "\u{001B}[1m"
        case .dim:
            return "\u{001B}[2m"
        case .italic:
            return "\u{001B}[3m"
        case .underline:
            return "\u{001B}[4m"
        case .blink:
            return "\u{001B}[5m"
        case .inverse:
            return "\u{001B}[7m"
        case .hidden:
            return "\u{001B}[8m"
        case .strikethrough:
            return "\u{001B}[9m"
            
        case .foregroundColor(let code):
            return "\u{001B}[38;5;\(code)m"
        case .backgroundColor(let code):
            return "\u{001B}[48;5;\(code)m"
        }
    }
}

@resultBuilder
struct ColoredStringBuilder {
    static func buildBlock(_ components: XtermColor...) -> String {
        return components.map { $0.description }.joined()
    }
}

struct ColoredString {
    static func Colored(color: XtermColor, string: String) -> String {
        return "\(color)\(string)\(XtermColor.reset)"
    }
}

func ANSI(color: ANSIColor, string: String) -> String {
    return "\(color.rawValue)\(string)\(ANSIColor.reset)"
}

func Xterm(color: XtermColor, string: String) -> String {
    return "\(color)\(string)\(XtermColor.reset)"
}

func printAllXtermColors() {
    for i in 0...255 {
        let coloredString = ColoredString.Colored(color: .foregroundColor(i), string: "\(i)")
        print(coloredString, terminator: " ")
        if (i + 1) % 16 == 0 {
            print()
        }
    }
}


