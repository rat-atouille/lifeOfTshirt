//
//  Landfill.swift
//  Life of a T-Shirt
//
//  Created by Heena Pong on 2026-02-28.
//

import SwiftUI

struct Landfill: View {
    @EnvironmentObject var setting: Settings

    var body: some View {
        VStack {
            // Title at the top
            Text(highlight("Your T-shirt is sent to a landfill, where many discarded clothes end up.", target: "landfill"))
                .font(.system(size: 50))
                .fontWeight(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 90)
                .padding(.top, 60)

            // Left: landfill visual | Right: descriptions
            HStack(alignment: .top, spacing: 40) {
                // Left side (placeholder for landfill visual/content)
                Image("landfill")
                    .resizable()
                    .scaledToFit()
                    .frame( width:600)
                    .grayscale(setting.color == .gray ? 1.0 : 0.0)
                VStack {
                    Spacer()
                }

                // Right side: descriptions
                VStack(alignment: .leading, spacing: 10) {
                    Text(highlight("When clothes are thrown away, the water, energy, and materials used to make them are lost. Some fabrics like polyester can also take many years to break down.", target: "water, energy, and materials"))
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color(hex: "#1a1a2e").opacity(0.72))

                    Text(highlight("Some people choose to repair, reuse, or recycle clothes to help extend their life and reduce waste.", target: "repair, reuse, or recycle"))
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color(hex: "#1a1a2e").opacity(0.72))
                        .padding(.top, 10)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.top, 20)
            }
            .padding(.horizontal, 60)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            

            Button("Continue") {
                setting.footprints.increaseCarbonMeter(amount: 4)
                setting.footprints.increaseWaterMeter(amount: 4)
                setting.progress.goTo(chapter: .four, page: 1)
            }.buttonStyle(ButtonCustom())
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.horizontal, 50)
                .padding(.vertical, 45)
        }.notebookBackground()
    }
}

#Preview {
    Landfill()
        .environmentObject(Settings())
}
