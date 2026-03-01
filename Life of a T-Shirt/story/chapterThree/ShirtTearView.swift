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
            Text("One day, you notice a small rip in your T-shirt.")
            Text("Accidents can happen, even to your favorite clothes. Now you need to decide what to do next.")
            Decide()
        }.notebookBackground()
    }
}


struct Decide: View {
    @EnvironmentObject var setting: Settings
    var body: some View {
        VStack {
            HStack {
                Button("Repair it") {
                    setting.progress.goTo(chapter: .three, page: 3)
                }.buttonStyle(ButtonCustom())
                
                Button("Throw it away") {
                    setting.progress.goTo(chapter: .three, page: 5)
                }.buttonStyle(ButtonCustom())
            }
        }
    }
}

#Preview {
    ShirtTearView()
        .environmentObject(Settings())
}
