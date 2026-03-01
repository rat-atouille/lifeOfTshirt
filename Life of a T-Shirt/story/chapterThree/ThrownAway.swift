//
//  ReplaceView.swift
//  Life of a T-Shirt
//
//  Created by Heena Pong on 2026-02-25.
//

import SwiftUI

struct ThrownAway: View {
    @EnvironmentObject var setting: Settings

    var body: some View {
        Text("You decide to throw your T-shirt away.")
        Text("Its journey with you comes to an end.")
        
        Button("Continue") {
            setting.progress.goTo(chapter: .three, page: 6)
        }.buttonStyle(ButtonCustom())
    }
}



#Preview {
    ThrownAway()
        .environmentObject(Settings())
}
