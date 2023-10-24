//
//  Color theme.swift
//  Colorizer
//
//  Created by Max Kiselyov on 10/21/23.
//

import UIKit

struct Theme {
    static func getMainColor() -> UIColor {
        switch UIScreen.main.traitCollection.userInterfaceStyle {
        case .light, .unspecified:
            return .white
        case .dark:
            return .black
        @unknown default:
            fatalError()
        }
    }
    
    static func getAccentColor() -> UIColor{
        switch UIScreen.main.traitCollection.userInterfaceStyle {
        case .light, .unspecified:
            return .black
        case .dark:
            return .white
        @unknown default:
            fatalError()
        }
    }
}
