//
//  ChapterTwo.swift
//  Life of a T-Shirt
//
//  Created by Heena Pong on 2026-02-25.
//

import SwiftUI

struct ChapterTwo: View {
    @EnvironmentObject var setting: Settings

    var body: some View {
        switch(setting.progress.chapter, setting.progress.page) {
        case (.two, 1):
            Washing()
        case (.two, 2):
            WashingGame()
        case (.two, 3):
            Clean()
        default:
            Text("")
        }
    }
}

#Preview {
    ChapterTwo()
        .environmentObject(Settings())

}
