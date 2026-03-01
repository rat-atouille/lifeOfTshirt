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
        Text("Your T-shirt is sent to a landfill, where many discarded clothes end up.")
        
        Text("When clothes are thrown away, the water, energy, and materials used to make them are lost. Some fabrics like polyester can also take many years to break down.")
        
        Text("Some people choose to repair, reuse, or recycle clothes to help extend their life and reduce waste.")

        
        Button("See your total footprint") {
            // go to dashboard
            setting.footprints.increaseCarbonMeter(amount: 4)
            setting.footprints.increaseWaterMeter(amount: 4)
            // microplastic?
            
            setting.progress.goTo(chapter: .four, page: 2)
        }.buttonStyle(ButtonCustom())
    }
}

#Preview {
    Landfill()
        .environmentObject(Settings())
}
