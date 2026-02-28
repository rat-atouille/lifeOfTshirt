//
//  Welcome.swift
//  Life of a T-Shirt
//
//  Created by Heena Pong on 2026-02-26.
//

import SwiftUI

struct Welcome: View {
    var body: some View {
        Text("Hi, there!")
            .font(.largeTitle)
            .padding()
        
        Text("Welcome to Life of a T-Shirt!")
            .font(.largeTitle)
            .padding()
        
        Text("Remember, choices you make cannot be undone. Think carefully and see how you can make an impact.")
            .font(.largeTitle)
            .padding()
    }
}

#Preview {
    Welcome()
        .environmentObject(Settings())
}
