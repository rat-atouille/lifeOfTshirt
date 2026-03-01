//
//  chapterOne.swift
//  Life of a T-Shirt
//
//  Created by Heena Pong on 2026-02-25.
//

import SwiftUI

struct ChapterOne: View {
    @EnvironmentObject var setting: Settings

    var body: some View {
        
        switch (setting.progress.chapter, setting.progress.page) {
        case (.one, 1):
            ChooseTshirt()
                .transition(.slide)
        case (.one, 2):
            ProductionView()
                .transition(.slide)
        case (.one, 3):
            ChapterOneResult()
                .transition(.slide)
        default:
            Text("")
        }
        
    }
}

#Preview {
    ChapterOne()
        .environmentObject(Settings())
}
