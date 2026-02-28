//
//  Result.swift
//  Life of a T-Shirt
//
//  Created by Heena Pong on 2026-02-24.
//

import SwiftUI

struct Result: View {
    @EnvironmentObject var setting: Settings

    var body: some View {
        Text("Your T-shirt's life ended.")
    }
}

struct Dashboard: View {
    var body: some View {
        Text("Your T-shirt's life ends here.")
        Text("Total water used:")
        Text("Carbon emitted:")
    }
}

#Preview {
    Result()
        .environmentObject(Settings())
}
