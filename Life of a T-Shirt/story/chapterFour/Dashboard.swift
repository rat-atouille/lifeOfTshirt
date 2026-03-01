//
//  Dashboard.swift
//  Life of a T-Shirt
//
//  Created by Heena Pong on 2026-02-28.
//

import SwiftUI

struct Dashboard: View {
    var body: some View {
        // Your T-shirt’s life ended early. Every discarded shirt contributes to environmental impact.

        // Your T-shirt continues to live. Extending its life reduces the need for new resources.
        Text("Water used:")
        Text("Carbon emitted:")
        Text("Microplastics released:")
    }
}

#Preview {
    Dashboard()
        .environmentObject(Settings())
}
