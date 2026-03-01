//
//  RepairReplace.swift
//  Life of a T-Shirt
//
//  Created by Heena Pong on 2026-02-24.
//

import SwiftUI



struct ShirtTearView: View {
    @EnvironmentObject var setting: Settings
    var body: some View {
        VStack {
            VStack {
                
                Image("ripShirt")
                    .resizable()
                    .scaledToFit()
                    .frame( height: 500)
                    .grayscale(setting.color == .gray ? 1.0 : 0.0)
                
                Text(highlight("One day, you notice a small rip in your T-shirt.", target: "a small rip"))
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(Color(hex: "#1a1a2e").opacity(0.72))

                Text("Accidents can happen, even to your favorite clothes.")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(Color(hex: "#1a1a2e").opacity(0.72))

                Text("Now you need to decide what to do next.")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(Color(hex: "#1a1a2e").opacity(0.72))
            }
            Decide()
        }.notebookBackground()
    }
}


struct Decide: View {
    @EnvironmentObject var setting: Settings
    var body: some View {
        VStack {
            HStack {
                Button("Fix it") {
                    setting.ending = .repair
                    setting.footprints.increaseCarbonMeter(amount: 1)
                    setting.progress.goTo(chapter: .three, page: 3)
                }.buttonStyle(ButtonCustom())
                
                Button("Throw it away") {
                    setting.ending = .thrownAway
                    setting.progress.goTo(chapter: .three, page: 4)
                    setting.footprints.increaseCarbonMeter(amount: 4)
                   setting.footprints.increaseWaterMeter(amount: 2)
                   setting.footprints.increaseMicroPlastic(amount: 1)
                }.buttonStyle(ButtonCustom())
            }.padding(.top, 20)
        }
    }
}

#Preview {
    ShirtTearView()
        .environmentObject(Settings())
}
