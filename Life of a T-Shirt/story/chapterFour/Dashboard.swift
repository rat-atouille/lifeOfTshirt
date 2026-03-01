//
//  Dashboard.swift
//  Life of a T-Shirt
//
//  Created by Heena Pong on 2026-02-28.
//

import SwiftUI

struct Dashboard: View {
    @EnvironmentObject var setting: Settings
    var body: some View {

        // Your T-shirt’s life ended early. Every discarded shirt contributes to environmental impact.

        // Your T-shirt continues to live. Extending its life reduces the need for new resources.
        VStack {
            Image("ending")
                .resizable()
                .scaledToFit()
                .frame( height:340)
                .grayscale(setting.color == .gray ? 1.0 : 0.0)
                .padding(.bottom, 20)
                //.border(.blue, width:3)
            
            Text(highlight("Impact You Made", target:"Impact"))
                .font(.system(size:45))
                .fontWeight(.black)
                .padding()
            
            VStack (spacing: 10) {
                Text("Water used:")
                    .font(.title)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 100)
                    .foregroundColor(Color(hex: "#1a1a2e").opacity(0.72))
                Text("Carbon emitted:")
                    .font(.title)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 100)
                    .foregroundColor(Color(hex: "#1a1a2e").opacity(0.72))
                Text("Microplastics released:")
                    .font(.title)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 100)
                    .foregroundColor(Color(hex: "#1a1a2e").opacity(0.72))
            }
            Button(action: {
                setting.progress.goTo(chapter: .one, page: 1)
            }) {
                Text("Play Again ↻")
            }.buttonStyle(ButtonCustom())
                .padding(.top, 40)
                .frame(maxWidth: .infinity)
        }.notebookBackground()
    }
}

#Preview {
    Dashboard()
        .environmentObject(Settings())
}
