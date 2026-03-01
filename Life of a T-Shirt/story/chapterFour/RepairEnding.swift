//
//  Result.swift
//  Life of a T-Shirt
//
//  Created by Heena Pong on 2026-02-24.
//

import SwiftUI

struct RepairEnding: View {
    @EnvironmentObject var setting: Settings

    var body: some View {
        VStack {
            Text("Chapter Four: The Journey Continues")
                .fontWeight(.bold)
                .font(.largeTitle)
            Text("Your T-shirt continues its journey with you.")
            
            Text("Every choice you made affected its impact on the environment.")
            Text("See the footprint of your T-shirt’s life so far.")
            Button("View your impact") {
                setting.progress.goTo(chapter: .four, page: 2)
            }.buttonStyle(ButtonCustom())
        }
    }
}


#Preview {
    RepairEnding()
        .environmentObject(Settings())
}
