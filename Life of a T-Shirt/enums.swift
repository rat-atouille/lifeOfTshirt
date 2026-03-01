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

enum Production: String, CaseIterable  {
        case fast
        case slow
    
        var keypoint: String {
        switch self {
        case .fast: return "Cheap and mass-produced."
        case .slow: return "Higher quality and longer-lasting."
            }
        }
    
        var bulletPoints: [String] {
        switch self {
        case .fast: return ["Low cost", "Widely available", "Trendy"]
        case .slow: return ["Higher quality", "Longer lifespan", "Eco-friendly"]
        }
        }
        
        var description: String {
        switch self {
        case .fast:
            return "Fast fashion makes clothes quickly so stores can sell the latest trends right away. This gives people many style choices at lower prices. These clothes are often made in large amounts using faster production methods. Because trends change often, people may wear these items for a shorter time before getting something new. Fast fashion clothes are usually made from cheaper fabrics and materials."

        case .slow: 
            return "Slow fashion focuses on making clothes that last longer and can be worn for many years. These clothes often use designs that don’t go out of style quickly. They may be made with more attention to materials and how they are put together. People may keep and wear these clothes longer before replacing them. Slow fashion clothes are usually made from natural fibers such as cotton or recycled fabrics."
        }
    }
}

enum Palette: String, CaseIterable {
    case white
    case yellow
    case black
    
    var color: Color {
        switch self {
        case .yellow: return .yellow
        case .white: return .white
        case .black: return .black
        }
    }
}

enum HotOrCold: String, CaseIterable {
    case hot
    case cold
    
    var description: String {
        switch self {
        case .hot: return ""
        case .cold: return ""
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
