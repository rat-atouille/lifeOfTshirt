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
            Text("Accidents can happen. Even to your favourite shirt.")
            Text("What do you do?")
            Decide()
        }
    }
}

struct Decide: View {
    @EnvironmentObject var setting: Settings
    var body: some View {
        VStack {
            HStack {
                Button("Repair") {
                    setting.progress.goTo(chapter: .three, page: 3)
                }.buttonStyle(ButtonCustom())
                
                Button("Replace") {
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
