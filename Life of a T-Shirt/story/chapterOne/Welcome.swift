//
//  Welcome.swift
//  Life of a T-Shirt
//
//  Created by Heena Pong on 2026-02-26.
//

import SwiftUI

struct Welcome: View {
    @EnvironmentObject var setting: Settings
    var body: some View {
        VStack (alignment: .center) {
            Text("Welcome to the Life of a T-Shirt")
                .font(.largeTitle)
                .fontWeight(.black)
                .padding()
            
            Text("Follow the journey of a T-shirt and discover how everyday choices influence its lifespan and environmental footprint.")
                .font(.largeTitle)
                .multilineTextAlignment(.center)
                .padding()
            
            Text("Choose thoughtfully. Every decision shapes the outcome.")
                .font(.largeTitle)
                .padding()
            
            Button(action: {
                setting.progress.goTo(chapter: .one, page: 1)
            }) {
                Text("Get Started")
            }.buttonStyle(ButtonCustom())
        }.notebookBackground()
    }
}

#Preview {
    Welcome()
        .environmentObject(Settings())
}
