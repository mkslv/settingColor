//
//  Color theme.swift
//  Colorizer
//
//  Created by Max Kiselyov on 10/21/23.
//

import UIKit

struct Theme {
    /// State of iOS theme osTheme: 1 - white; 2 - black.
    static var osTheme: UIUserInterfaceStyle {
        UIScreen.main.traitCollection.userInterfaceStyle
    }
    
    /// Color of backgroubndColor
    static var mainColor: UIColor {
        switch osTheme.rawValue {
        case 1:
            return .white
        case 2:
            return .black
        default:
            return .systemMint
        }
    }
    
    /// Accent color of secondary elements
    static var accentColor: UIColor {
        switch osTheme.rawValue {
        case 1:
            return .black
        default:
            return .white
        }
    }
}
