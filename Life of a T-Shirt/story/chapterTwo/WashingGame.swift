//
//  WashingGame.swift
//  Life of a T-Shirt
//
//  Created by Heena Pong on 2026-02-26.
//

import SwiftUI

struct WashingGame: View {
    @EnvironmentObject var setting: Settings
    @State private var drawnPath: [CGPoint] = []
    @State private var circleCount: Int = 0
    @State private var totalAngle: Double = 0
    @State private var lastAngle: Double?
    @State private var gameComplete: Bool = false
    @State private var particlePositions: [CGPoint] = []
    
    let targetCircles: Int = 3
    let centerPoint = CGPoint(x: 175, y: 270)
    
    var body: some View {
        VStack {
            Text("Roll the washing machine!")
                .font(.largeTitle)
                .fontWeight(.black)
                .padding(.bottom, 5)
            Text("Draw circles in the dotted space area to wash our laundry.")
                .foregroundColor(Color(hex: "#1a1a2e").opacity(0.72))
                .fontWeight(.semibold)
                .font(.title2)
                .italic()
            
            // Progress circles
            HStack(spacing: 20) {
                ForEach(0..<targetCircles, id: \.self) { index in
                    ZStack {
                        Circle()
                            .stroke(Color.blue.opacity(0.3), lineWidth: 3)
                            .frame(width: 50, height: 50)
                        
                        if index < circleCount {
                            Image(systemName: "checkmark.circle.fill")
                                .font(.system(size: 40))
                                .foregroundColor(.blue)
                                .transition(.scale)
                        } else if index == circleCount {
                            Circle()
                                .trim(from: 0, to: CGFloat(totalAngle / (2 * .pi)))
                                .stroke(Color.blue, lineWidth: 3)
                                .frame(width: 50, height: 50)
                                .rotationEffect(.degrees(-90))
                                .animation(.linear(duration: 0.1), value: totalAngle)
                        }
                    }
                }.padding(.top, 15)
            }
            
            // Drawing canvas
            ZStack {
                Image("washKitty")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 600, height: 500)
                
                ForEach([300, 280, 260], id: \.self) { size in
                    Circle()
                        .stroke(Color.blue, style: StrokeStyle(lineWidth: 3, dash: [10, 5]))
                        .frame(width: CGFloat(size), height: CGFloat(size))
                        .position(centerPoint)
                }
                
                // Water particles animation
                ForEach(particlePositions.indices, id: \.self) { index in
                    Circle()
                        .fill(.blue)
                        .frame(width: 8, height: 8)
                        .position(particlePositions[index])
                }
                
                // User's path with gradient
                Path { path in
                    guard drawnPath.count > 1 else { return }
                    path.move(to: drawnPath[0])
                    for point in drawnPath.dropFirst() {
                        path.addLine(to: point)
                    }
                }
                .stroke(
                    LinearGradient(
                        gradient: Gradient(colors: [.blue.opacity(0.2), .cyan, .blue]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round)
                )
                
                // Center indicator
                Circle()
                    .fill(.blue)
                    .frame(width: 8, height: 8)
                    .position(centerPoint)
                
                if gameComplete {
                    VStack {
                        Image(systemName: "sparkles")
                            .font(.system(size: 60))
                            .foregroundColor(.blue)
                    }
                    .scaleEffect(gameComplete ? 1 : 0)
                    .animation(.spring(response: 0.5, dampingFraction: 0.6), value: gameComplete)
                }
            }
            .frame(width: 600, height: 500)
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { value in
                        handleContinuousDrawing(at: value.location)
                    }
                    .onEnded { _ in
                        // Allow brief lift without resetting
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            if drawnPath.count < targetCircles * 100 {
                                withAnimation {
                                    drawnPath = []
                                    totalAngle = 0
                                    lastAngle = nil
                                }
                            }
                        }
                    }
            )
            
            if !gameComplete {
                Text("Keep drawing circles!")
                    .foregroundColor(.blue)
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.top, 8)
            }
            
            if gameComplete {
                VStack(spacing: 16) {
                    if setting.material == .polyester {
                        HStack {
                            Image(systemName: "drop.fill")
                                .foregroundColor(.red)
                            Text("Thousands of microplastics released during the washing process")
                                .foregroundColor(.red)
                                .fontWeight(.semibold)
                        }
                    }
                    
                    Button("Continue") {
                        applyWashingEffects()
                        setting.progress.goTo(chapter: .two, page: 3)
                    }
                    .buttonStyle(ButtonCustom())
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.horizontal, 25)
                }
                .padding()
            }
        }
        .notebookBackground()
    }
    
    func handleContinuousDrawing(at location: CGPoint) {
        drawnPath.append(location)
        
        // Limit path size
        if drawnPath.count > 150 {
            drawnPath.removeFirst(50)
        }
        
        // Calculate current angle from center
        let dx = location.x - centerPoint.x
        let dy = location.y - centerPoint.y
        let currentAngle = atan2(dy, dx)
        
        if let last = lastAngle {
            var angleDiff = currentAngle - last
            
            // Handle wraparound
            if angleDiff > .pi {
                angleDiff -= 2 * .pi
            } else if angleDiff < -.pi {
                angleDiff += 2 * .pi
            }
            
            // Only count clockwise or counter-clockwise consistently
            if abs(angleDiff) < 0.5 {  // Ignore erratic jumps
                totalAngle += abs(angleDiff)
                
                // Add water particle occasionally
                if Int.random(in: 0...10) == 0 {
                    particlePositions.append(location)
                    if particlePositions.count > 20 {
                        particlePositions.removeFirst()
                    }
                }
            }
            
            // Check if completed a full rotation
            if totalAngle >= 2 * .pi {
                circleCount += 1
                totalAngle = 0
                generateHapticFeedback()
                
                if circleCount >= targetCircles {
                    withAnimation(.spring()) {
                        gameComplete = true
                    }
                }
            }
        }
        
        lastAngle = currentAngle
    }
    
    func generateHapticFeedback() {
        #if os(iOS)
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        #endif
    }
    
    func applyWashingEffects() {
        if setting.material == .polyester {
            // cold
            setting.footprints.increaseCarbonMeter(amount: 2)
            setting.footprints.increaseWaterMeter(amount: 1)
            setting.footprints.increaseMicroPlastic(amount: 2)

            // hot wash
//            setting.footprints.increaseCarbonMeter(amount: 2)
//            setting.footprints.increaseMicroPlastic(amount: 4)
//            setting.footprints.increaseWaterMeter(amount: 3)
        } else {
            // cold
            setting.footprints.increaseCarbonMeter(amount: 2)
            setting.footprints.increaseWaterMeter(amount: 1)

//            // hot wash
//            setting.footprints.increaseCarbonMeter(amount: 3)
//            setting.footprints.increaseWaterMeter(amount: 0)
        }
    }
}


#Preview {
    WashingGame().environmentObject(Settings())
}
