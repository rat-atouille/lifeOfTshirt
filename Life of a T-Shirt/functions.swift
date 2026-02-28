//
//  functions.swift
//  Life of a T-Shirt
//
//  Created by Heena Pong on 2026-02-24.
//

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
    var tshirtHealth: Int = 0
    var numberOfUses: Int = 0
    var carbonMeter: Int =  0
    var waterMeter:  Int = 0
    
    mutating func increaseNumberOfUses(amount: Int) {
        numberOfUses += amount
    }
    
    mutating func increaseTshirtHealth(amount: Int) {
        tshirtHealth += amount
    }
    
    mutating func increaseCarbonMeter(amount: Int) {
        carbonMeter += amount
    }
    
    mutating func increaseWaterMeter(amount: Int) {
        waterMeter += amount
    }
}


