//
//  BackgroundView.swift
//  Life of a T-Shirt
//
//  Created by Heena Pong on 2026-02-27.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        ZStack {
            // Paper color
            Color(red: 1.0, green: 0.98, blue: 0.85)
                .ignoresSafeArea()
            
            GeometryReader { geometry in
                // Horizontal lines (like ruled paper)
                VStack(spacing: 0) {
                    ForEach(0..<Int(geometry.size.height / 32), id: \.self) { _ in
                        Divider()
                            .background(Color.blue.opacity(0.2))
                            .frame(height: 1)
                        Spacer()
                            .frame(height: 31)
                    }
                }
                
                // Vertical margin line (red line on left)
                Rectangle()
                    .fill(Color.red.opacity(0.3))
                    .frame(width: 2)
                    .offset(x: 50)
            }
           // .ignoresSafeArea()
        }
    }
}

extension View {
    func notebookBackground() -> some View {
        ZStack {
            BackgroundView()
            self
        }
    }
}
#Preview {
    BackgroundView()
}
