//
//  ButtonCustom.swift
//  Life of a T-Shirt
//
//  Created by Heena Pong on 2026-02-22.
//

import Foundation
import SwiftUI

struct ButtonCustom: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .fontWeight(.black)
            .foregroundStyle(.white)
            .padding(.horizontal, 20)
            .padding(.vertical, 15)
            .background(configuration.isPressed ? .black.opacity(0.8) : .black)
            .cornerRadius(14)
    }
}
