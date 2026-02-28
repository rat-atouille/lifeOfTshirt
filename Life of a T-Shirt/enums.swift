//
//  enums.swift
//  Life of a T-Shirt
//
//  Created by Heena Pong on 2026-02-21.
//

import Foundation
import SwiftUI

enum Material: String, CaseIterable {
    case cotton
    case polyester
    
    var description: String {
        switch self {
        case .cotton: return "this is cotton. natural fiber"
        case .polyester: return "polyester. syntentic fiber"
        }
    }
}

enum Production: String, CaseIterable {
        case fast
        case slow
    
        var description: String {
        switch self {
        case .fast: return "this is a fast fashion brand"
        case .slow: return "this is a slow fashion brand"
        }
    }
}

enum Palette: String, CaseIterable {
    case white
    case red
    case yellow
    case blue
    case black
    
    var color: Color {
        switch self {
        case .red: return .red
        case .blue: return .blue
        case .yellow: return .yellow
        case .white: return .white
        case .black: return .black
        }
    }
}

enum Chapter: Int, CaseIterable {
    case one = 1
    case two = 2
    case three = 3
    case four = 4
    
    var totalPages: Int {
        switch self {
        case .one: return 4
        case .two: return 3
        case .three: return 7
        case .four: return 2
        }
    }
}
