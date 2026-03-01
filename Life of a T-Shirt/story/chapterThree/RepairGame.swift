
import SwiftUI
import SwiftUI

struct StitchPoint: Identifiable {
    let id = UUID()
    let position: CGPoint
    let side: StitchSide
    var isCompleted: Bool = false
}

enum StitchSide {
    case left, right
}

struct RepairGame: View {
    @EnvironmentObject var setting: Settings
    @State private var stitchPoints: [StitchPoint] = []
    @State private var completedPath: [CGPoint] = []
    @State private var currentDragPoint: CGPoint? = nil
    @State private var nextPointIndex: Int = 0
    @State private var isComplete: Bool = false
    @State private var showSuccess: Bool = false

    let numberOfPoints = 6
    let hitRadius: CGFloat = 30

    var body: some View {
        GeometryReader { geo in
            let width = geo.size.width
            let height = geo.size.height
            let centerX = width / 2
            let spacing = height / CGFloat(numberOfPoints + 1)

            ZStack {

                // Torn fabric shadow (left side)
                Path { p in
                    p.move(to: CGPoint(x: centerX - 3, y: 0))
                    p.addLine(to: CGPoint(x: centerX - 3, y: height))
                }
                .stroke(Color(white: 0.6).opacity(0.4), lineWidth: 6)

                // The Rip — jagged dashed line
                Path { p in
                    p.move(to: CGPoint(x: centerX, y: 0))
                    var y: CGFloat = 0
                    while y < height {
                        let jitter = CGFloat.random(in: -5...5)
                        p.addLine(to: CGPoint(x: centerX + jitter, y: y + 18))
                        y += 18
                    }
                }
                .stroke(Color.black, style: StrokeStyle(lineWidth: 2, dash: [5, 3]))

                // Completed stitch path
                if completedPath.count > 1 {
                    Path { p in
                        p.move(to: completedPath[0])
                        for point in completedPath.dropFirst() {
                            p.addLine(to: point)
                        }
                    }
                    .stroke(
                        Color.black,
                        style: StrokeStyle(lineWidth: 2.5, lineCap: .round, lineJoin: .round, dash: [7, 5])
                    )
                }

                // Live drag line from last completed to finger
                if let drag = currentDragPoint,
                   let last = completedPath.last,
                   !isComplete {
                    Path { p in
                        p.move(to: last)
                        p.addLine(to: drag)
                    }
                    .stroke(
                        Color.black.opacity(0.35),
                        style: StrokeStyle(lineWidth: 2, lineCap: .round, dash: [4, 4])
                    )
                }

                // Stitch target points
                ForEach(stitchPoints.indices, id: \.self) { i in
                    let point = stitchPoints[i]
                    let isNext = i == nextPointIndex && !isComplete

                    ZStack {
                        Circle()
                            .fill(point.isCompleted ? Color.black : Color.white)
                            .frame(width: isNext ? 28 : 22, height: isNext ? 28 : 22)
                            .overlay(
                                Circle()
                                    .stroke(Color.black, lineWidth: isNext ? 2.5 : 1.5)
                            )
                            .shadow(color: .black.opacity(0.15), radius: 2, x: 1, y: 1)
                            .scaleEffect(isNext ? 1.1 : 1.0)
                            .animation(
                                isNext ? .easeInOut(duration: 0.6).repeatForever(autoreverses: true) : .default,
                                value: nextPointIndex
                            )

                        if point.isCompleted {
                            Image(systemName: "checkmark")
                                .font(.system(size: 10, weight: .bold))
                                .foregroundColor(.white)
                        }
                    }
                    .position(point.position)
                }

                // Instruction banner
                if !isComplete {
                    VStack(spacing: 3) {
                        Text("Stitch the rip together!")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        if nextPointIndex < stitchPoints.count {
                            Text(stitchPoints[nextPointIndex].side == .left ? "← stitch left" : "stitch right →")
                                .fontWeight(.semibold)
                                .foregroundColor(Color(white: 0.35))
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                    .background(Color.white)
                    .cornerRadius(15)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.black, lineWidth: 1.5)
                    )
                    .position(x: centerX, y: 48)
                }

                // Success overlay
                if showSuccess {
                    ZStack {
                        // Full screen blur + dim
                        Rectangle()
                            .fill(.ultraThinMaterial)
                            .ignoresSafeArea()
                            .overlay(Color.black.opacity(0.4))
                            .ignoresSafeArea()
                        
                        VStack(spacing: 20) {
                            Text("STITCHED")
                                .font(.largeTitle)
                                .foregroundColor(.black)
                                .fontWeight(.black)
                                .tracking(4)
                            Rectangle()
                                .fill(.black)
                                .frame(height: 1.5)
                                .padding(.horizontal, 10)
                            Text("You repaired your T-shirt and gave it a longer life.")
                                .foregroundColor(.black)
                            Text("Repairing clothes helps reduce waste and lowers the need for new resources. Your T-shirt is ready to be worn again.")
                                .foregroundColor(.black)
                            Button("Continue") {
                                setting.progress.goTo(chapter: .four, page: 1)
                            }
                            .buttonStyle(ButtonCustom())
                        }
                        .padding(36)
                        .background(.white)
                        .cornerRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.black, lineWidth: 2)
                        )
                        .padding(.horizontal, 200)
                    }
                    .ignoresSafeArea()
                    .transition(.opacity.combined(with: .scale(scale: 0.95)))
                }
            }
            .onAppear {
                setupPoints(width: width, height: height, centerX: centerX, spacing: spacing)
            }
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { value in
                        guard !isComplete else { return }
                        currentDragPoint = value.location

                        if nextPointIndex < stitchPoints.count {
                            let target = stitchPoints[nextPointIndex]
                            let dist = distance(value.location, target.position)
                            if dist < hitRadius {
                                stitchPoints[nextPointIndex].isCompleted = true
                                completedPath.append(target.position)
                                nextPointIndex += 1

                                if nextPointIndex >= stitchPoints.count {
                                    isComplete = true
                                    currentDragPoint = nil
                                    withAnimation(.spring()) {
                                        showSuccess = true
                                    }
                                }
                            }
                        }
                    }
                    .onEnded { _ in
                        currentDragPoint = nil
                    }
            )
        }
        .notebookBackground()
    }

    func setupPoints(width: CGFloat, height: CGFloat, centerX: CGFloat, spacing: CGFloat) {
        let offset: CGFloat = 60
        var points: [StitchPoint] = []
        points.append(StitchPoint(position: CGPoint(x: centerX, y: spacing), side: .left))

        for i in 1..<numberOfPoints {
            let y = spacing * CGFloat(i + 1)
            let side: StitchSide = i.isMultiple(of: 2) ? .right : .left
            let x = side == .left ? centerX - offset : centerX + offset
            points.append(StitchPoint(position: CGPoint(x: x, y: y), side: side))
        }

        stitchPoints = points
        if let first = points.first {
            completedPath = [first.position]
            stitchPoints[0].isCompleted = true
            nextPointIndex = 1
        }
    }

    func distance(_ a: CGPoint, _ b: CGPoint) -> CGFloat {
        sqrt(pow(a.x - b.x, 2) + pow(a.y - b.y, 2))
    }
}
#Preview {
    RepairGame()
        .environmentObject(Settings())
}
