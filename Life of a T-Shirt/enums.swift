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
    
    var keypoint: String {
        switch self {
        case .cotton: return "Natural and breathable."
        case .polyester: return "Synthetic and durable."
        }
    }
        
    var description: String {
        switch self {
        case .cotton: return "Cotton is made from plant fibers and feels soft and comfortable, but it requires large amounts of water and energy to grow and produce."
        case .polyester: return "Polyester is made from plastic and uses less water in production, but it releases microplastics during washing and does not biodegrade easily."
        }
    }
}

enum Production: String, CaseIterable {
        case fast
        case slow
    
        var keypoint: String {
        switch self {
        case .fast: return "Cheap and mass-produced."
        case .slow: return "Higher quality and longer-lasting."
            }
        }
    
        
        var description: String {
        switch self {
        case .fast: return "Fast fashion prioritizes speed and low cost, often resulting in lower quality garments that wear out quickly and contribute to more waste."
        case .slow: return "Slow fashion focuses on durability and responsible production, reducing waste and environmental impact over time."
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
    case zero = 0
    case one = 1
    case two = 2
    case three = 3
    case four = 4
    
    var totalPages: Int {
        switch self {
        case .zero: return 1
        case .one: return 4
        case .two: return 3
        case .three: return 7
        case .four: return 2
        }
    }
}
