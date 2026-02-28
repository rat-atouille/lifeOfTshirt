//
//  Production.swift
//  Life of a T-Shirt
//
//  Created by Heena Pong on 2026-02-24.
//

import SwiftUI

struct ProductionView: View {
    @EnvironmentObject var setting: Settings
    @State var chosenOption: String = ""
    var body: some View {
        VStack {
            Text("Choose A Production Method.")
                .font(Font.largeTitle.bold())
                .padding(.horizontal, 25)
                .padding(.vertical, 25)
            HStack {
                OptionView(chosenOption: $chosenOption)
            }
            Button("I'm done") {
                setting.progress.goTo(chapter: .one, page: 4)
//                if chosenOption == "sustain" {
//                    setting.progress.goTo(chapter: .one, page: 3)
//                } else  {
//                    //if chosenOption == "fast"
//                    setting.progress.goTo(chapter: .one, page: 4)
//                }
                // if chosenOption == "" -> disable button
            }.buttonStyle(ButtonCustom())
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.horizontal, 25)
            .padding(.vertical, 25)
            .border(Color.blue, width: 3)
        }
        
    }
}

struct OptionView: View {
    @EnvironmentObject var setting: Settings
    @Binding var chosenOption: String
    
    var body: some View {
        HStack {
            
            // Sustain
            VStack {
                
                Text("Slow Fashion.")
            }
            
            // Fast
            VStack {
                Text("Fast Fashion.")
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .border(Color.green, width: 2)
    }
}

struct SlowView: View {
    @EnvironmentObject var setting: Settings

    var body: some View {
        VStack {
            Text("Slow")
            Button("I'm done") {
                setting.progress.goTo(chapter: .two, page: 1)
            }
        }
    }
}

struct FastView: View {
    @EnvironmentObject var setting: Settings

    var body: some View {
        VStack {
            Text("Fast")
            Button("I'm done") {
                setting.progress.goTo(chapter: .two, page: 1)
            }
        }
    }
}

#Preview {
    ProductionView()
        .environmentObject(Settings())
}
