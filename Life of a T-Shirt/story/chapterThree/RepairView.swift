//
//  RepairView.swift
//  Life of a T-Shirt
//
//  Created by Heena Pong on 2026-02-25.
//

import SwiftUI

struct RepairView: View {
    @EnvironmentObject var setting: Settings

    var body: some View {
        Text("You decide to get a repair one.")
        Text("Let's stitch up the holes!")
        
        Button("Next") {
            setting.progress.goTo(chapter: .three, page: 4)
        }.buttonStyle(ButtonCustom())
    }
}

struct RepairGame: View {
    @EnvironmentObject var setting: Settings

    var body: some View {
        Text("something here")
        Button("Next") {
            setting.progress.goTo(chapter: .three, page: 7)
        }.buttonStyle(ButtonCustom())
    }
}

struct FixedView: View {
    @EnvironmentObject var setting: Settings

    var body: some View {
        Text("All fixed! As good as new. Almost!")
        Button("Next") {
            setting.progress.goTo(chapter: .four, page: 1)
        }.buttonStyle(ButtonCustom())
    }
}

#Preview {
    RepairView()
        .environmentObject(Settings())
}
