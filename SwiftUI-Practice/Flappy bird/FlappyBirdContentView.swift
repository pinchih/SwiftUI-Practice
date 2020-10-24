//
//  FlappyBirdContentView.swift
//  SwiftUI-Practice
//
//  Created by Pin-Chih Lin on 10/21/20.
//

import SwiftUI
import Combine

struct FlappyBirdContentView: View {
    
    @ObservedObject var controller = GameController()
    
    var body: some View {
        backgroundView()
            .overlay(scoreView())
            .overlay(birdView())
            .ignoresSafeArea()
            .onTapGesture(perform: {
                controller.makeBirdFlap()
            })
            .onAppear {
                controller.startGame()
            }
            .alert(isPresented: $controller.isGameOver,
                   content: gameOverAlertContent)
    }
    
}

// MARK: - Helpers
extension FlappyBirdContentView {
    
    private var gameOverAlertContent: () -> Alert {
        {
            Alert(title: Text("Game Over"),
                  dismissButton: .default(Text("Play again"), action: {
                    controller.restartGame()
                  }))
        }
    }
    
    private func scoreView() -> some View {
        VStack {
            HStack {
                Spacer()
                Text("\(controller.score)")
                    .font(.largeTitle)
                    .padding()
                    .offset(x: -20.0, y: 20.0)
            }
            Spacer()
        }
    }
    
    private func upperPillarView() -> some View {
        Rectangle()
            .foregroundColor(.green)
            .frame(width: controller.pillarWidth,
                   height: controller.upperPillarHeight)
            .overlay(GeometryReader { geometry in
                Color.clear.preference(key: FramePreferenceKey.self,
                                       value: geometry.frame(in: .global))
            })
            .onPreferenceChange(FramePreferenceKey.self, perform: { frame in
                controller.upperPillarFrame = frame
            })
            .offset(x: controller.pillarOffsetX)
    }
    
    private func lowerPillarView() -> some View {
        Rectangle()
            .foregroundColor(.green)
            .frame(width: controller.pillarWidth,
                   height: controller.lowerPillarHeight)
            .overlay(GeometryReader { geometry in
                Color.clear.preference(key: FramePreferenceKey.self,
                                       value: geometry.frame(in: .global))
            })
            .onPreferenceChange(FramePreferenceKey.self, perform: { frame in
                controller.lowerPillarFrame = frame
            })
            .offset(x: controller.pillarOffsetX)
    }
    
    private func backgroundView() -> some View {
        VStack {
            upperPillarView()
            Spacer()
                .frame(height: controller.pillarGap)
            lowerPillarView()
        }.frame(minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity,
                alignment: .center
        )
        .background(Color.white)
    }
    
    private func birdView() -> some View {
        BirdView()
            .frame(width: GameController.Config.defaultBirdWidth,
                   height: GameController.Config.defaultBirdWidth,
                   alignment: .center)
            .offset(x: -120, y: controller.birdOffsetY)
            .onPreferenceChange(FramePreferenceKey.self, perform: { value in
                controller.birdFrame = value
            })
    }
    
}

// MARK: - Previous
struct FlappyBirdContentView_Previous: PreviewProvider {
    static var previews: some View {
        FlappyBirdContentView()
            .previewDevice(PreviewDevice(rawValue: "iPhone XR"))
    }
}
