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
            VStack (spacing: 40){
                Text(highlight("Chapter Two: Washing", target: "Washing"))
                    .fontWeight(.black)
                    .font(.system(size:50))
                
                Text("You’ve been wearing your T-shirt often, and now it needs to be washed.")
                    .fontWeight(.semibold)
                    .font(.title)
                    .foregroundColor(Color(hex: "#1a1a2e").opacity(0.72))

                Text("Washing is part of every T-shirt’s life, but it can affect both its condition and its impact on the environment.")
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .font(.title)
                    .foregroundColor(Color(hex: "#1a1a2e").opacity(0.72))

            }.padding(130)
              //  .border(.red, width: 3)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
           
            Button("Continue") {
                setting.progress.goTo(chapter: .two, page: 2)
            }.buttonStyle(ButtonCustom())
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.horizontal, 25)
            .padding(.vertical, 25)
        }.notebookBackground()
    }
}

#Preview {
    Washing().environmentObject(Settings())
}
