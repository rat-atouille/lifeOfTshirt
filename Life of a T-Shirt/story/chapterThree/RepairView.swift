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
        Text("You decide to repair your T-shirt.")
        Text("With a small fix, it can be worn again.")
        
        Button("Repair your T-shirt") {
            setting.progress.goTo(chapter: .three, page: 4)
        }.buttonStyle(ButtonCustom())
    }
}


#Preview {
    RepairView()
        .environmentObject(Settings())
}
