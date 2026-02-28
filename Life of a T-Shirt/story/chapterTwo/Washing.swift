//
//  Washing.swift
//  Life of a T-Shirt
//
//  Created by Heena Pong on 2026-02-24.
//

import SwiftUI

struct Washing: View {
    @EnvironmentObject var setting: Settings
    var repeatLoop: Int = 3
    
    var body: some View {
        VStack {
            Text("Now you have your T-Shirt! You wear it a lot. You decide it's time for a wash.")
            Text("Let's wash your new T-shirt with your other clothes.")
            Button("Next") {
                setting.progress.goTo(chapter: .two, page: 2)
            }.buttonStyle(ButtonCustom())
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.horizontal, 25)
            .padding(.vertical, 25)
            .border(Color.blue, width: 3)
        }
    }
}

struct Clean: View {
    @EnvironmentObject var setting: Settings

    var body: some View {
        Button("Next") {
            setting.progress.goTo(chapter: .three, page: 1)
        }.buttonStyle(ButtonCustom())
    }
}

#Preview {
    Washing().environmentObject(Settings())
}
