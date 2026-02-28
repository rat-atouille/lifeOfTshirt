//
//  chooseTshirt.swift
//  Life of a T-shirt
//
//  Created by Heena Pong on 2026-02-21.
//

import SwiftUI

struct ChooseTshirt: View {
    @EnvironmentObject var setting: Settings
    @State private var appeared = false

    var body: some View {
        GeometryReader { geo in
            ZStack {
                // ── Deep Apple-style gradient background ──────────────────
                LinearGradient(
                    colors: [
                        Color(hex: "#0A0A1A"),
                        Color(hex: "#0D1B2A"),
                        Color(hex: "#0A0A1FF")
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                // Ambient orbs (like Apple's mesh gradients)
                AmbientOrbs(selectedColor: setting.color)

                // ── Content ───────────────────────────────────────────────
                    // iPad / landscape layout
                    HStack(spacing: 24) {
                        TShirtPreviewPanel()
                            .frame(width: geo.size.width * 0.42)
                            .opacity(appeared ? 1 : 0)
                            .offset(x: appeared ? 0 : -30)

                        ConfigPanel()
                            .opacity(appeared ? 1 : 0)
                            .offset(x: appeared ? 0 : 30)
                    }
                    .padding(24)
            }
        }
        .onAppear {
            withAnimation(.spring(response: 0.7, dampingFraction: 0.85)) {
                appeared = true
            }
        }
    }
}

// MARK: - Ambient Background Orbs

struct AmbientOrbs: View {
    let selectedColor: Color

    var body: some View {
        ZStack {
            // Large diffuse orb — follows selected t-shirt color
            Circle()
                .fill(selectedColor.opacity(0.18))
                .frame(width: 500, height: 500)
                .blur(radius: 100)
                .offset(x: -80, y: -120)
                .animation(.easeInOut(duration: 0.8), value: selectedColor)

            // Secondary cool orb
            Circle()
                .fill(Color(hex: "#1C6EF2").opacity(0.12))
                .frame(width: 400, height: 400)
                .blur(radius: 90)
                .offset(x: 150, y: 200)

            // Accent orb
            Circle()
                .fill(Color(hex: "#5E5CE6").opacity(0.10))
                .frame(width: 300, height: 300)
                .blur(radius: 80)
                .offset(x: -200, y: 300)
        }
        .ignoresSafeArea()
    }
}

// MARK: - Glass Modifier

struct GlassMorphism: ViewModifier {
    var cornerRadius: CGFloat = 20
    var opacity: Double = 0.12

    func body(content: Content) -> some View {
        content
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(.ultraThinMaterial)

                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(Color.white.opacity(opacity))

                    RoundedRectangle(cornerRadius: cornerRadius)
                        .strokeBorder(
                            LinearGradient(
                                colors: [
                                    Color.white.opacity(0.35),
                                    Color.white.opacity(0.05)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 0.8
                        )
                }
            )
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .shadow(color: Color.black.opacity(0.25), radius: 20, x: 0, y: 8)
    }
}

extension View {
    func glassMorphism(cornerRadius: CGFloat = 20, opacity: Double = 0.12) -> some View {
        modifier(GlassMorphism(cornerRadius: cornerRadius, opacity: opacity))
    }
}

// MARK: - T-Shirt Preview Panel

struct TShirtPreviewPanel: View {
    @EnvironmentObject var setting: Settings

    var body: some View {
        VStack(spacing: 0) {
            // Header bar
            HStack {
                Text("PREVIEW")
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    .foregroundColor(.white.opacity(0.5))
                    .kerning(2.5)
                Spacer()

            }
            .padding(.horizontal, 22)
            .padding(.top, 20)
            .padding(.bottom, 14)

            Divider()
                .background(Color.white.opacity(0.08))
                .padding(.horizontal, 22)

            Spacer()

            // T-Shirt with glow
            ZStack {
                Ellipse()
                    .fill(setting.color.opacity(0.25))
                    .frame(width: 240, height: 200)
                    .blur(radius: 50)
                    .animation(.easeInOut(duration: 0.6), value: setting.color)

                ZStack {
                    // Shirt body
                    TShirtShape()
                        .fill(
                            LinearGradient(
                                colors: [setting.color.opacity(0.92), setting.color],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .shadow(color: setting.color.opacity(0.5), radius: 30, x: 0, y: 15)
                        .shadow(color: Color.black.opacity(0.4), radius: 10, x: 0, y: 5)
                        .animation(.spring(response: 0.4, dampingFraction: 0.7), value: setting.color)

                    // Shirt outline stroke
                    TShirtShape()
                        .stroke(setting.color.opacity(0.6), lineWidth: 1.5)

                    // Collar inner (lighter grey ring, like ribbed collar)
                    CollarShape()
                        .fill(Color.white.opacity(0.18))

                    CollarShape()
                        .stroke(Color.white.opacity(0.35), lineWidth: 1.5)

                    // Specular sheen
                    TShirtShape()
                        .fill(
                            LinearGradient(
                                colors: [Color.white.opacity(0.20), Color.clear],
                                startPoint: .top,
                                endPoint: .center
                            )
                        )
                }
                .frame(width: 400, height: 400)
            }

            Spacer()

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .glassMorphism(cornerRadius: 24)
    }
}

struct SpecPill: View {
    let label: String
    var body: some View {
        Text(label)
            .font(.system(size: 10, weight: .bold, design: .rounded))
            .foregroundColor(.white.opacity(0.65))
            .kerning(1.5)
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .background(Color.white.opacity(0.08))
            .clipShape(Capsule())
            .overlay(Capsule().strokeBorder(Color.white.opacity(0.12), lineWidth: 0.5))
    }
}

// MARK: - Config Panel

struct ConfigPanel: View {
    @EnvironmentObject var setting: Settings

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Header
            VStack(alignment: .leading, spacing: 4) {
                Text("Customize")
                    .font(.system(size: 40, weight: .semibold, design: .rounded))
                    .foregroundStyle(
                        LinearGradient(
                            colors: [.white, Color.white.opacity(0.75)],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                Text("Choose your material and color")
                    .font(.system(size: 30, weight: .regular, design: .rounded))
                    .foregroundColor(.white.opacity(0.45))
            }
            .padding(.horizontal, 24)
            .padding(.top, 26)

            Divider()
                .background(Color.white.opacity(0.08))
                .padding(.horizontal, 24)
                .padding(.top, 18)
                .padding(.bottom, 24)

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 28) {
                    VStack(alignment: .leading, spacing: 14) {
                        AppleSectionHeader(text: "Material")
                        MaterialView()
                    }
                    VStack(alignment: .leading, spacing: 14) {
                        AppleSectionHeader(text: "Color")
                        ColorView()
                    }
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 24)
            }

            Spacer()

            // CTA Button
            Button(action: {
                setting.progress.goTo(chapter: .one, page: 2)
            }) {
                HStack {
                    Text("Continue to Production")
                        .font(.system(size: 23, weight: .semibold, design: .rounded))
                    Spacer()
                    Image(systemName: "arrow.right.circle.fill")
                        .font(.system(size: 23))
                }
                .foregroundColor(.white)
                .padding(.horizontal, 22)
                .padding(.vertical, 17)
                .background(
                    LinearGradient(
                        colors: [Color(hex: "#1C6EF2"), Color(hex: "#0051D5")],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .shadow(color: Color(hex: "#1C6EF2").opacity(0.45), radius: 14, x: 0, y: 6)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .strokeBorder(Color.white.opacity(0.15), lineWidth: 0.5)
                )
            }
            .buttonStyle(PlainButtonStyle())
            .padding(.horizontal, 24)
            .padding(.bottom, 24)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .glassMorphism(cornerRadius: 24)
    }
}

struct AppleSectionHeader: View {
    let text: String
    var body: some View {
        Text(text)
            .font(.system(size: 25, weight: .semibold, design: .rounded))
            .foregroundColor(.white.opacity(0.45))
    }
}

// MARK: - Material View

struct MaterialView: View {
    @EnvironmentObject var setting: Settings
    @State var selectedInfo: Material? = nil

    var body: some View {
        HStack(spacing: 12) {
            ForEach(Material.allCases, id: \.self) { type in
                MaterialCard(
                    type: type,
                    isSelected: setting.material == type,
                    selectedInfo: $selectedInfo
                )
                .onTapGesture {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                        setting.material = type
                    }
                }
            }
        }
    }
}

struct MaterialCard: View {
    let type: Material
    let isSelected: Bool
    @Binding var selectedInfo: Material?

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ZStack(alignment: .topTrailing) {
                RoundedRectangle(cornerRadius: 12)
                    .fill(
                        LinearGradient(
                            colors: isSelected
                                ? [Color.white.opacity(0.25), Color.white.opacity(0.10)]
                                : [Color.white.opacity(0.08), Color.white.opacity(0.03)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(height: 72)
                    .overlay(
                        GeometryReader { geo in
                            Path { path in
                                for i in stride(from: CGFloat(0), to: geo.size.width + geo.size.height, by: 10) {
                                    path.move(to: CGPoint(x: i, y: 0))
                                    path.addLine(to: CGPoint(x: 0, y: i))
                                }
                            }
                            .stroke(Color.white.opacity(isSelected ? 0.12 : 0.05), lineWidth: 0.5)
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .strokeBorder(
                                isSelected ? Color.white.opacity(0.4) : Color.white.opacity(0.08),
                                lineWidth: isSelected ? 1 : 0.5
                            )
                    )

                Button(action: { selectedInfo = type }) {
                    Image(systemName: "info")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.white.opacity(0.6))
                        .frame(width: 18, height: 18)
                        .background(Color.white.opacity(0.15))
                        .clipShape(Circle())
                        .overlay(Circle().strokeBorder(Color.white.opacity(0.2), lineWidth: 0.5))
                }
                .padding(8)
                .popover(isPresented: Binding(
                    get: { selectedInfo == type },
                    set: { if !$0 { selectedInfo = nil } }
                )) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(type.rawValue.uppercased())
                            .font(.system(size: 11, weight: .bold, design: .rounded))
                            .foregroundColor(.secondary)
                            .kerning(2)
                        Text(type.description)
                            .font(.system(size: 14, design: .rounded))
                    }
                    .padding(18)
                    .presentationCompactAdaptation(.popover)
                }
            }

            HStack(spacing: 5) {
                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 20))
                        .foregroundColor(Color(hex: "#30D158"))
                }
                Text(type.rawValue.uppercased())
                    .font(.system(size: 11, weight: .semibold, design: .rounded))
                    .foregroundColor(isSelected ? .white : .white.opacity(0.4))
                    .kerning(1)
            }
        }
        .frame(maxWidth: .infinity)
    }
}

// MARK: - Color View

struct ColorView: View {
    @EnvironmentObject var setting: Settings

    var body: some View {
        HStack(spacing: 16) {
            ForEach(Palette.allCases, id: \.self) { col in
                let isSelected = setting.color == Color(col.color)

                ZStack {
                    if isSelected {
                        Circle()
                            .strokeBorder(Color.white.opacity(0.6), lineWidth: 2)
                            .frame(width: 46, height: 46)
                    }

                    Circle()
                        .fill(Color(col.color))
                        .frame(width: 36, height: 36)
                        .shadow(
                            color: Color(col.color).opacity(isSelected ? 0.7 : 0.3),
                            radius: isSelected ? 10 : 4
                        )
                        .overlay(
                            Circle()
                                .fill(
                                    RadialGradient(
                                        colors: [Color.white.opacity(0.4), Color.clear],
                                        center: UnitPoint(x: 0.35, y: 0.3),
                                        startRadius: 0,
                                        endRadius: 18
                                    )
                                )
                        )
                }
                .onTapGesture {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.65)) {
                        setting.color = Color(col.color)
                    }
                }
            }
        }
    }
}

// MARK: - T-Shirt Shape

struct TShirtShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let w = rect.width
        let h = rect.height

        // Start at left collar edge
        path.move(to: CGPoint(x: w * 0.30, y: h * 0.02))

        // Left shoulder slope down to left sleeve top
        path.addLine(to: CGPoint(x: w * 0.01, y: h * 0.18))

        // Left sleeve outer edge (slightly curved, boxy)
        path.addCurve(
            to: CGPoint(x: w * 0.01, y: h * 0.38),
            control1: CGPoint(x: w * -0.01, y: h * 0.24),
            control2: CGPoint(x: w * -0.01, y: h * 0.32)
        )

        // Left sleeve bottom back toward body
        path.addLine(to: CGPoint(x: w * 0.20, y: h * 0.40))

        // Left side seam, slightly curved inward then out
        path.addCurve(
            to: CGPoint(x: w * 0.18, y: h * 0.92),
            control1: CGPoint(x: w * 0.19, y: h * 0.52),
            control2: CGPoint(x: w * 0.17, y: h * 0.78)
        )

        // Bottom left corner rounded
        path.addCurve(
            to: CGPoint(x: w * 0.26, y: h * 1.00),
            control1: CGPoint(x: w * 0.18, y: h * 0.97),
            control2: CGPoint(x: w * 0.21, y: h * 1.00)
        )

        // Bottom hem (straight)
        path.addLine(to: CGPoint(x: w * 0.74, y: h * 1.00))

        // Bottom right corner rounded
        path.addCurve(
            to: CGPoint(x: w * 0.82, y: h * 0.92),
            control1: CGPoint(x: w * 0.79, y: h * 1.00),
            control2: CGPoint(x: w * 0.82, y: h * 0.97)
        )

        // Right side seam
        path.addCurve(
            to: CGPoint(x: w * 0.80, y: h * 0.40),
            control1: CGPoint(x: w * 0.83, y: h * 0.78),
            control2: CGPoint(x: w * 0.81, y: h * 0.52)
        )

        // Right sleeve bottom
        path.addLine(to: CGPoint(x: w * 0.99, y: h * 0.38))

        // Right sleeve outer edge
        path.addCurve(
            to: CGPoint(x: w * 0.99, y: h * 0.18),
            control1: CGPoint(x: w * 1.01, y: h * 0.32),
            control2: CGPoint(x: w * 1.01, y: h * 0.24)
        )

        // Right shoulder back to collar
        path.addLine(to: CGPoint(x: w * 0.70, y: h * 0.02))

        // Collar arc (crew neck)
        path.addCurve(
            to: CGPoint(x: w * 0.30, y: h * 0.02),
            control1: CGPoint(x: w * 0.62, y: h * 0.16),
            control2: CGPoint(x: w * 0.38, y: h * 0.16)
        )

        path.closeSubpath()
        return path
    }
}

// Inner collar ring shape
struct CollarShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let w = rect.width
        let h = rect.height

        path.move(to: CGPoint(x: w * 0.32, y: h * 0.03))
        path.addCurve(
            to: CGPoint(x: w * 0.68, y: h * 0.03),
            control1: CGPoint(x: w * 0.40, y: h * 0.155),
            control2: CGPoint(x: w * 0.60, y: h * 0.155)
        )
        path.addCurve(
            to: CGPoint(x: w * 0.32, y: h * 0.03),
            control1: CGPoint(x: w * 0.58, y: h * 0.13),
            control2: CGPoint(x: w * 0.42, y: h * 0.13)
        )
        path.closeSubpath()
        return path
    }
}

// MARK: - Hex Color Extension

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3:  (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:  (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:  (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default: (a, r, g, b) = (255, 255, 255, 255)
        }
        self.init(.sRGB,
                  red: Double(r) / 255,
                  green: Double(g) / 255,
                  blue: Double(b) / 255,
                  opacity: Double(a) / 255)
    }
}

// MARK: - Preview

#Preview {
    ChooseTshirt().environmentObject(Settings())
}
