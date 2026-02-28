//
//  ReplaceView.swift
//  Life of a T-Shirt
//
//  Created by Heena Pong on 2026-02-25.
//

import SwiftUI

struct ReplaceView: View {
    @EnvironmentObject var setting: Settings

    var body: some View {
        Text("You decide to get a new one.")
        Text("Let's what happens to discarded clothes.")
        
        Button("Next") {
            setting.progress.goTo(chapter: .three, page: 6)
        }.buttonStyle(ButtonCustom())
    }
}

struct Landfill: View {
    var body: some View {
        Text("Stats here")
       
    }
}

#Preview {
    ReplaceView()
        .environmentObject(Settings())
}
