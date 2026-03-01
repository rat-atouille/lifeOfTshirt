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
                Text("Chapter Two: Washing")
                    .fontWeight(.black)
                    .font(.largeTitle)
                Text("You’ve been wearing your T-shirt often, and now it needs to be washed.")
                    .fontWeight(.black)
                    .font(.largeTitle)
                Text("Washing is part of every T-shirt’s life, but it can affect both its condition and its impact on the environment.")
                    .fontWeight(.black)
                    .multilineTextAlignment(.center)
                    .font(.largeTitle)
            }.padding(50)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
           
            Button("Next") {
                setting.progress.goTo(chapter: .two, page: 2)
            }.buttonStyle(ButtonCustom())
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.horizontal, 25)
            .padding(.vertical, 25)
            .border(Color.blue, width: 3)
        }.notebookBackground()
    }
}

#Preview {
    Washing().environmentObject(Settings())
}
