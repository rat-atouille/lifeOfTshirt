
import SwiftUI

struct ChooseTshirt: View {
    @EnvironmentObject var setting: Settings
    @State private var selectedInfo: Material? = nil

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                Text(highlight("Chapter One: A New T-Shirt", target: "A New T-Shirt"))
                    .foregroundColor(.black)
                    .fontWeight(.black)
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                    .padding(.top, 100)
                
                Text("Design your new t-shirt!")
                    .foregroundColor(.black)
                    .fontWeight(.semibold)
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .padding(.top, 25)

                // 50/50 horizontal split using GeometryReader
                GeometryReader { geo in
                    HStack(spacing: 0) {
                        TShirtView()
                            .frame(width: geo.size.width * 0.5, height: geo.size.height)

                        // subtle divider
                        Rectangle()
                            .fill(Color(hex: "#1a1a2e").opacity(0.1))
                            .frame(width: 1)

                        ChoiceView()
                            .padding(.leading, 40)
                            .frame(width: geo.size.width * 0.5, height: geo.size.height)
                    }
                }

                // button section
                Button("Go to production →") {
                    if setting.material == .cotton {
                        setting.footprints.increaseWaterMeter(amount: 4)
                        setting.footprints.increaseCarbonMeter(amount: 2)
                        setting.footprints.increaseMicroPlastic(amount: 0)
                    } else if setting.material == .polyester {
                        setting.footprints.increaseWaterMeter(amount: 1)
                        setting.footprints.increaseCarbonMeter(amount: 3)
                        setting.footprints.increaseMicroPlastic(amount: 3)
                    }
                    setting.progress.goTo(chapter: .one, page: 2)
                }
                .buttonStyle(ButtonCustom())
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.trailing, 60)
                .padding(.bottom, 40)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .notebookBackground()

            if let info = selectedInfo {
                InfoOverlay(material: info, onDismiss: { selectedInfo = nil })
                    .ignoresSafeArea()
            }
        }
        .environment(\.openMaterialInfo, { selectedInfo = $0 })
    }
}

// MARK: - Choice Panel

struct ChoiceView: View {
    var body: some View {
        VStack(spacing: 50) {
            MaterialView()
        }
        .padding(.horizontal, 24)
        //.background(.white)
    }
}

// MARK: - T-Shirt Preview

struct TShirtView: View {
    @EnvironmentObject var setting: Settings

    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 12) {
                Spacer()
                Image("kitty")
                    .resizable()
                    .scaledToFit()
                    // shirt scales with available height, max 60% of the panel height
                    .frame(height: geo.size.height * 0.55)
                    .foregroundColor(setting.color.color)
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

// MARK: - Material View

struct MaterialView: View {
    @EnvironmentObject var setting: Settings
    @Environment(\.openMaterialInfo) var openMaterialInfo

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("Choose a material")
                .foregroundColor(.black)
                .fontWeight(.bold)
                .font(.title)

            VStack(spacing: 12) {
                ForEach(Material.allCases, id: \.self) { type in
                    MaterialCheckbox(
                        type: type,
                        isSelected: setting.material == type,
                        onSelect: { setting.material = type },
                        onInfo: { openMaterialInfo(type) }
                    )
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct MaterialCheckbox: View {
    let type: Material
    let isSelected: Bool
    let onSelect: () -> Void
    let onInfo: () -> Void

    var body: some View {
        HStack(spacing: 14) {
            // Checkbox
            ZStack {
                RoundedRectangle(cornerRadius: 4)
                    .fill(isSelected
                          ? Color(hex: "#1a1a2e").opacity(0.07)
                          : Color.white.opacity(0.3))
                    .frame(width: 28, height: 28)
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(Color.white, lineWidth: isSelected ? 2 : 0)
                            .padding(-2)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(Color.black, lineWidth: isSelected ? 2 : 0)
                            .padding(-5)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(
                                Color(hex: "#1a1a2e").opacity(isSelected ? 0 : 0.3),
                                style: StrokeStyle(lineWidth: 1, dash: [4, 2])
                            )
                    )

                if isSelected {
                    Image(systemName: "checkmark")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(Color(hex: "#1a1a2e"))
                }
            }
            .onTapGesture { onSelect() }

            // Label + info button together, label grows, button stays close
            HStack(spacing: 8) {
                Text(type.rawValue.capitalized)
                    .foregroundColor(.black)
                    .font(.body)

                Button(action: onInfo) {
                    Image(systemName: "info.circle")
                        .font(.system(size: 17))
                        .foregroundColor(.black)
                }
            }
            .onTapGesture { onSelect() }
        }
        // This makes every row the same width so checkboxes line up
        .frame(maxWidth: .infinity, alignment: .leading)
        .contentShape(Rectangle())
    }
}

// MARK: - Info Overlay (full screen)

struct InfoOverlay: View {
    let material: Material
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
                    Text(material.rawValue.capitalized)
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

                Text(material.keypoint)
                    .foregroundColor(.black)
                    .fontWeight(.semibold)
                Text(material.description)
                    .foregroundColor(Color(hex: "#1a1a2e").opacity(0.72))
                    .lineSpacing(5)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding(22)
            .background(
                RoundedRectangle(cornerRadius: 20)
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

// MARK: - Environment key for opening material info

private struct OpenMaterialInfoKey: EnvironmentKey {
    static let defaultValue: (Material) -> Void = { _ in }
}

extension EnvironmentValues {
    var openMaterialInfo: (Material) -> Void {
        get { self[OpenMaterialInfoKey.self] }
        set { self[OpenMaterialInfoKey.self] = newValue }
    }
}

// MARK: - Hex color helper

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
        default: (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(.sRGB, red: Double(r)/255, green: Double(g)/255,
                  blue: Double(b)/255, opacity: Double(a)/255)
    }
}

#Preview {
    ChooseTshirt().environmentObject(Settings())
}
#Preview {
    ChooseTshirt().environmentObject(Settings())
}
