//
//  ChapterFour.swift
//  Life of a T-Shirt
//
//  Created by Heena Pong on 2026-02-25.
//

import SwiftUI

struct ChapterFour: View {
    @EnvironmentObject var setting: Settings

    var body: some View {
        
        switch (setting.progress.chapter, setting.progress.page) {
        case (.four, 1):
            RepairEnding()
        case (.four, 2):
            Dashboard()
        default:
            Text("")
        }
        
    }
}

#Preview {
    ChapterFour()
        .environmentObject(Settings())
}
