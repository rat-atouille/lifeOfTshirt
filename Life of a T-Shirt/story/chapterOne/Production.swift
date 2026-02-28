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
    @State private var selectedInfo: String? = nil

    var body: some View {
        ZStack {
            VStack {
                Text("Choose A Production Method.")
                    .font(Font.largeTitle.bold())
                    .padding(.horizontal, 25)
                    .padding(.vertical, 25)

                HStack(spacing: 0) {
                    FashionOptionCard(
                        title: "Slow Fashion.",
                        option: "slow",
                        chosenOption: $chosenOption,
                        onInfo: { selectedInfo = "slow" }
                    )

                    FashionOptionCard(
                        title: "Fast Fashion.",
                        option: "fast",
                        chosenOption: $chosenOption,
                        onInfo: { selectedInfo = "fast" }
                    )
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)

                Button("I'm done") {
                    setting.progress.goTo(chapter: .one, page: 4)
                }
                .buttonStyle(ButtonCustom())
                .frame(maxWidth: .infinity, alignment: .trailing)
            }.padding(.horizontal, 30)
            .padding(.vertical, 25)
            .border(.blue, width: 3)
           

            if let info = selectedInfo {
                ProductionInfoOverlay(option: info, onDismiss: { selectedInfo = nil })
                    .ignoresSafeArea()
            }
        } .notebookBackground()
    }
}

struct FashionOptionCard: View {
    let title: String
    let option: String
    @Binding var chosenOption: String
    let onInfo: () -> Void

    var isSelected: Bool { chosenOption == option }

    var body: some View {
        VStack(spacing: 20) {
            // Image placeholder
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.gray.opacity(0.15))
                .frame(maxWidth: .infinity)
                .frame(height: 180)
                .overlay(
                    VStack(spacing: 8) {
                        Image(systemName: "photo")
                            .font(.system(size: 36))
                            .foregroundColor(.gray.opacity(0.4))
                        Text("Image placeholder")
                            .font(.caption)
                            .foregroundColor(.gray.opacity(0.4))
                    }
                )

            // Title + info button
            HStack(spacing: 8) {
                Text(title)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.black)

                Button(action: onInfo) {
                    Image(systemName: "info.circle")
                        .font(.system(size: 17))
                        .foregroundColor(Color(hex: "#1a1a2e").opacity(0.35))
                }
            }
        }
        .padding(20)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(isSelected ? Color.black.opacity(0.06) : Color.clear)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.white, lineWidth: isSelected ? 2 : 0)
                .padding(-2)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.black, lineWidth: isSelected ? 2 : 0)
                .padding(-5)
        )
        .contentShape(Rectangle())
        .onTapGesture { chosenOption = option }
    }
}

// MARK: - Info Overlay

struct ProductionInfoOverlay: View {
    let option: String
    let onDismiss: () -> Void
    @State private var appeared = false

    var title: String { option == "sustain" ? "Slow Fashion" : "Fast Fashion" }
    var description: String {
        option == "sustain"
            ? "Placeholder description for slow fashion."
            : "Placeholder description for fast fashion."
    }

    var body: some View {
        ZStack {
            Rectangle()
                .fill(.ultraThinMaterial)
                .background(Color.black.opacity(0.28))
                .ignoresSafeArea()
                .onTapGesture { dismiss() }
                .opacity(appeared ? 1 : 0)

            VStack(alignment: .leading, spacing: 14) {
                HStack {
                    Text(title)
                        .font(.custom("Bradley Hand", size: 22))
                        .foregroundColor(Color(hex: "#1a1a2e"))
                    Spacer()
                    Button(action: { dismiss() }) {
                        Text("✕")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(Color(hex: "#1a1a2e").opacity(0.45))
                    }
                }

                Rectangle()
                    .fill(Color(hex: "#1a1a2e").opacity(0.12))
                    .frame(height: 1)

                Text(description)
                    .font(.custom("Bradley Hand", size: 16))
                    .foregroundColor(Color(hex: "#1a1a2e").opacity(0.72))
                    .lineSpacing(5)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding(22)
            .background(
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color(hex: "#fefcf5"))
                    .shadow(color: Color.black.opacity(0.1), radius: 18, y: 6)
            )
            .padding(.horizontal, 28)
            .scaleEffect(appeared ? 1 : 0.93)
            .opacity(appeared ? 1 : 0)
        }
        .onAppear {
            withAnimation(.spring(response: 0.35, dampingFraction: 0.78)) {
                appeared = true
            }
        }
    }

    private func dismiss() {
        withAnimation(.easeOut(duration: 0.18)) { appeared = false }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.18) { onDismiss() }
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
        }.notebookBackground()
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
        }.notebookBackground()
    }
}

#Preview {
    ProductionView()
        .environmentObject(Settings())
}
