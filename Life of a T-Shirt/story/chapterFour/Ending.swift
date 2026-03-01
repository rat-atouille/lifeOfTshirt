//
//  Result.swift
//  Life of a T-Shirt
//
//  Created by Heena Pong on 2026-02-24.
//

import SwiftUI

struct Ending: View {
    @EnvironmentObject var setting: Settings
    
    var body: some View {
        VStack {
            
            VStack {
                
                // Title
                Text(highlight(chapterTitle, target: highlightTarget))
                    .font(.system(size: 50))
                    .fontWeight(.black)
                    .padding()
                
                VStack(spacing: 13) {
                    
                    Text(line1)
                        .font(.title)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 100)
                        .foregroundColor(Color(hex: "#1a1a2e").opacity(0.72))
                    
                    Text(line2)
                        .font(.title)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 100)
                        .foregroundColor(Color(hex: "#1a1a2e").opacity(0.72))
                    
                    Text(line3)
                        .font(.title)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 100)
                        .foregroundColor(Color(hex: "#1a1a2e").opacity(0.72))
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            
            Button("View your impact") {
                setting.progress.goTo(chapter: .four, page: 2)
            }
            .buttonStyle(ButtonCustom())
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.trailing, 60)
            .padding(.bottom, 30)
        }
        .notebookBackground()
    }
}

extension Ending {
    
    var chapterTitle: String {
        if setting.RepairOrThrownAway == .repair {
            return "Chapter Four: The Journey Continues"
        } else {
            return "Chapter Four: The Journey Ends"
        }
    }
    
    var highlightTarget: String {
        if setting.RepairOrThrownAway == .repair {
            return "The Journey Continues"
        } else {
            return "The Journey Ends"
        }
    }
    
    var line1: String {
        if setting.RepairOrThrownAway == .repair {
            return "Your T-shirt continues its journey with you."
        } else {
            return "Your T-shirt’s journey has come to an end."
        }
    }
    
    var line2: String {
        if setting.RepairOrThrownAway == .repair {
            return "Every choice you made affected its impact on the environment."
        } else {
            return "Its environmental impact was shaped by the choices made during its life."
        }
    }
    
    var line3: String {
        if setting.RepairOrThrownAway == .repair {
            return "See the footprint of your T-shirt’s life so far."
        } else {
            return "See the total footprint of your T-shirt’s life."
        }
    }
}

#Preview {
    Ending()
        .environmentObject(Settings())
}
