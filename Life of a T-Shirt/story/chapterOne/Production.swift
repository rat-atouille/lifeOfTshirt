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
    @State private var selectedInfo: Production? = nil

    var body: some View {
        ZStack {
            VStack {
                Text("Where are you getting your T-shirt from?")
                    .font(Font.largeTitle.bold())
                    .padding(.horizontal, 25)
                    .padding(.vertical, 25)

                HStack(spacing: 25) {
                    ForEach(Production.allCases, id: \.self) { type in
                        ProductionCard(
                            title: "\(type.rawValue.capitalized) Fashion",
                            option: type.rawValue,
                            chosenOption: $chosenOption,
                            onInfo: { selectedInfo = type },
                            bulletPoints: type.bulletPoints
                        )
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)

                Button("Continue") {
                    if setting.production == .slow {
                        // higher durability -> fewer replacements -> fewer total impacts
                        setting.footprints.increaseCarbonMeter(amount: 2)
                    } else if setting.production == .fast {
                        // higher carbon and lower durability
                        setting.footprints.increaseCarbonMeter(amount: 3)
                    }
                    setting.progress.goTo(chapter: .one, page: 3)
//                    if setting.production == .slow {
//                        setting.progress.goTo(chapter: .one, page: 3)
//                    } else if setting.production == .fast {
//                        setting.progress.goTo(chapter: .one, page: 4)
//                    }
                }
                .buttonStyle(ButtonCustom())
                .disabled(setting.production == nil)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.top, 20)
            }
            .padding(.horizontal, 30)
            .padding(.vertical, 25)

            if let info = selectedInfo {
                ProductionInfoOverlay(option: info, onDismiss: { selectedInfo = nil })
                    .ignoresSafeArea()
            }
        }
        .notebookBackground()
    }
}

struct ProductionCard: View {
    @EnvironmentObject var setting: Settings

    let title: String
    let option: String
    @Binding var chosenOption: String
    let onInfo: () -> Void
    let bulletPoints: [String]
    
    var isSelected: Bool { chosenOption == option }

    var body: some View {
        let content = VStack(spacing: 20) {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.gray.opacity(0.15))
                .frame(maxWidth: .infinity)
                .frame(height: 400)
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
            HStack {
                HStack (spacing: 10){
                    ForEach(bulletPoints, id: \.self) { point in
                        Text(point)
                        
                    }.padding(.horizontal, 15)
                        .padding(.vertical, 10)
                    .background(.gray)
                    .foregroundStyle(Color.white)
                    .fontWeight(.semibold)
                    .cornerRadius(20)
                }
            }
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .top)
        .background(isSelected ? Color.black.opacity(0.06) : Color.clear)
        .contentShape(Rectangle())
        .onTapGesture {
            chosenOption = option
            setting.production = Production(rawValue: option)
        }

        return content
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
    }
}

// MARK: - Info Overlay

struct ProductionInfoOverlay: View {
    let option: Production
    let onDismiss: () -> Void
    @State private var appeared = false

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
                    Text("\(option.rawValue.capitalized) Fashion")
                        .fontWeight(.black)
                        .font(.title)
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

                Text(option.keypoint)
                    .foregroundColor(.black)
                    .fontWeight(.semibold)

                Text(option.description)
                    .foregroundColor(Color(hex: "#1a1a2e").opacity(0.72))
                    .lineSpacing(5)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding(22)
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color(hex: "#fefcf5"))
                    .stroke(Color.black, lineWidth: 1.5)
                    .shadow(color: Color.black.opacity(0.1), radius: 18, y: 6)
            )
            .padding(.horizontal, 200)
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

#Preview {
    ProductionView()
        .environmentObject(Settings())
}
