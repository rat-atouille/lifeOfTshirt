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
                
                // Chapter title
                Text(highlight(chapterTitle, target: highlightTarget))
                    .font(.system(size: 50))
                    .fontWeight(.black)
                    .padding()
                
                // Description text
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


// MARK: - Computed text properties
extension Ending {
    
    var chapterTitle: String {
        switch setting.ending {
        case .repair:
            return "Chapter Four: The Journey Continues"
        case .thrownAway:
            return "Chapter Four: The Journey Ends"
        case nil:
            return "Chapter Four"
        }
    }
    
    var highlightTarget: String {
        switch setting.ending {
        case .repair:
            return "The Journey Continues"
        case .thrownAway:
            return "The Journey Ends"
        case nil:
            return ""
        }
    }
    
    var line1: String {
        switch setting.ending {
        case .repair:
            return "Your T-shirt continues its journey with you."
        case .thrownAway:
            return "Your T-shirt’s journey has come to an end."
        case nil:
            return ""
        }
    }
    
    var line2: String {
        switch setting.ending {
        case .repair:
            return "Repairing it reduced waste and saved resources."
        case .thrownAway:
            return "Discarding it contributed to environmental waste."
        case nil:
            return ""
        }
    }
    
    var line3: String {
        switch setting.ending {
        case .repair:
            return "See the footprint of your T-shirt’s life so far."
        case .thrownAway:
            return "See the total footprint of your T-shirt’s life."
        case nil:
            return ""
        }
    }
}
#Preview {
    Ending()
        .environmentObject(Settings())
}
