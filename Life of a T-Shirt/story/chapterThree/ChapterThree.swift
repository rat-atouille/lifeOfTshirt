//
//  ChapterThree.swift
//  Life of a T-Shirt
//
//  Created by Heena Pong on 2026-02-25.
//

import SwiftUI

struct ChapterThree: View {
    @EnvironmentObject var setting: Settings

    var body: some View {
        switch(setting.progress.chapter, setting.progress.page) {
        case (.three, 1):
            ChapterThreeIntro()
        case (.three, 2):
            ShirtTearView()
        case (.three, 3):
            RepairGame()
        case (.three, 4):
            Landfill()
        default:
            Text("")
        }
    }
}

#Preview {
    ChapterTwo()
        .environmentObject(Settings())

}
