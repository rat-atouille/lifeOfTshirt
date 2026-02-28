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
            ShirtTearView()
        case (.three, 2):
            Decide()
        case (.three, 3):
            RepairView()
        case (.three, 4):
            RepairGame()
        case (.three, 5):
            ReplaceView()
        case (.three, 6):
            Landfill()
        case (.three, 7):
            FixedView()
        default:
            Text("")
        }
    }
}

#Preview {
    ChapterTwo()
        .environmentObject(Settings())

}
