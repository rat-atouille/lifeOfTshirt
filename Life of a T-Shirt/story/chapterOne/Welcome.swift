//
//  Welcome.swift
//  Life of a T-Shirt
//
//  Created by Heena Pong on 2026-02-26.
//

import SwiftUI

struct Welcome: View {
    @EnvironmentObject var setting: Settings
    
    var highlightedText: AttributedString {
        var text = AttributedString("welcome to the life of a t shirt")

        if let range = text.range(of: "life of a t shirt") {
            text[range].backgroundColor = .yellow
            text[range].foregroundColor = .black
            text[range].font = .system(size: 17, weight: .semibold)
        }

        return text
    }
    var body: some View {
        VStack (alignment: .center) {
            VStack {
                Text(highlight("Welcome to the Life of a T-Shirt", target:"Life of a T-Shirt"))
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .padding()
                
                Image("kitty")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                Text("Follow the journey of a T-shirt and discover how everyday choices influence its lifespan and environmental footprint.")
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 100)
                
                Text("Choose thoughtfully. Every decision shapes the outcome.")
                    .font(.title)
                    .padding()
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
            Button(action: {
                setting.progress.goTo(chapter: .one, page: 1)
            }) {
                Text("Get Started")
            }.buttonStyle(ButtonCustom())
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.trailing, 60)
                .padding(.bottom, 40)
        }.notebookBackground()
    }
}

#Preview {
    Welcome()
        .environmentObject(Settings())
}
