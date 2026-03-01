//
//  Clean.swift
//  Life of a T-Shirt
//
//  Created by Heena Pong on 2026-02-28.
//

import SwiftUI

struct Clean: View {
    @EnvironmentObject var setting: Settings

    var body: some View {
        VStack{
            Text("Yay! Now our clothes are clean!")
            Button("Next") {
                setting.progress.goTo(chapter: .three, page: 1)
            }.buttonStyle(ButtonCustom())
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.horizontal, 25)
                .padding(.vertical, 25)
                .border(Color.blue, width: 3)
        }.notebookBackground()

    }
}

#Preview {
    Clean().environmentObject(Settings())
}
