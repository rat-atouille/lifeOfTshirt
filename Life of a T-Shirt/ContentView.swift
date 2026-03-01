//
//  ContentView.swift
//  Life of a T-Shirt
//
//  Created by Heena Pong on 2026-02-21.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var setting: Settings

    var body: some View {
        CurrentView()
    }
}

struct CurrentView: View {
    @EnvironmentObject var setting: Settings

    var body: some View {
        switch (setting.progress.chapter) {
        case (.zero):
            Welcome()
        case (.one):
            ChapterOne()
            let _ = print(setting)
        case (.two):
            ChapterTwo()
        case (.three):
            ChapterThree()
        case (.four):
            ChapterFour()
        }
    }
}

// game settings
class Settings: ObservableObject {
    @Published var progress = Progress()
    @Published var footprints = Footprints()
    @Published var material: Material? = nil
    @Published var color: Palette? = nil
    @Published var production: Production? = nil
    @Published var ending: RepairOrThrownAway? = nil
}

#Preview {
    ContentView()
        .environmentObject(Settings())
}
