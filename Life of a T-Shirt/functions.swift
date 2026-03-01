//
//  functions.swift
//  Life of a T-Shirt
//
//  Created by Heena Pong on 2026-02-24.
//

import SwiftUI
import Foundation

struct Progress {
    var chapter: Chapter = .zero
    var page: Int = 1
    
    mutating func goTo(chapter: Chapter, page: Int) {
        guard Chapter.allCases.contains(chapter) else { return }
        
        self.chapter = chapter
        self.page = min(max(1, page), chapter.totalPages)
    }
}

struct Footprints {
    var carbonMeter: Int = 0
    var waterMeter: Int = 0
    var microplasticMeter: Int = 0

    mutating func increaseMicroPlastic(amount: Int) {
        microplasticMeter += amount
    }

    mutating func increaseCarbonMeter(amount: Int) {
        carbonMeter += amount
    }

    mutating func increaseWaterMeter(amount: Int) {
        waterMeter += amount
    }

    var carbonImpact: ImpactLevel {
        switch carbonMeter {
        case 0..<6: return .low
        case 6..<10: return .medium
        default: return .high
        }
    }

    var waterImpact: ImpactLevel {
        switch waterMeter {
        case 0..<5: return .low
        case 5..<8: return .medium
        default: return .high
        }
    }

    var microplasticImpact: ImpactLevel {
        switch microplasticMeter {
        case 0..<3: return .low
        case 3..<6: return .medium
        default: return .high
        }
    }
}

func color(for impact: ImpactLevel) -> Color {
    switch impact {
    case .low: return .green
    case .medium: return .orange
    case .high: return .red
    }
}

func highlight(_ full: String, target: String) -> AttributedString {
    var attributed = AttributedString(full)

    if let range = attributed.range(of: target) {
        attributed[range].backgroundColor = .yellow
    }

    return attributed
}


