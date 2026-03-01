//
//  RepairReplace.swift
//  Life of a T-Shirt
//
//  Created by Heena Pong on 2026-02-24.
//

import SwiftUI



struct ShirtTearView: View {
    var body: some View {
        VStack {
            VStack {
                Text(highlight("One day, you notice a small rip in your T-shirt.", target: "a small rip"))
                    .font(.title2)
                    .fontWeight(.bold)
                Text("Accidents can happen, even to your favorite clothes.")
                    .font(.title2)
                    .fontWeight(.bold)
                Text("Now you need to decide what to do next.")
                    .font(.title2)
                    .fontWeight(.bold)
            }
            Decide()
        }.notebookBackground()
    }
}


struct Decide: View {
    @EnvironmentObject var setting: Settings
    var body: some View {
        VStack {
            HStack {
                Button("Fix it") {
                    setting.progress.goTo(chapter: .three, page: 3)
                }.buttonStyle(ButtonCustom())
                
                Button("Throw it away") {
                    setting.progress.goTo(chapter: .three, page: 4)
                }.buttonStyle(ButtonCustom())
            }
        }
    }
}

#Preview {
    ShirtTearView()
        .environmentObject(Settings())
}
