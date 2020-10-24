//
//  GameController.swift
//  SwiftUI-Practice
//
//  Created by Pin-Chih Lin on 10/21/20.
//

import SwiftUI
import Combine
import DisplayLink

final class GameController: ObservableObject {
    
    struct Config {
        static let defaultPillarWidth: CGFloat = 50
        static let defaultPillarGap: CGFloat = 200
        static let defaultPillarMoveUnit: CGFloat = 3
        static let defaultBirdWidth: CGFloat = 40
    }
    
    private let halfScreenHeight = UIScreen.main.bounds.height / 2
    
    @Published
    var score: Int = 0
    
    @Published
    var isGameOver = false
    
    @ObservedObject
    private var birdViewModel = BirdViewModel()
    
    @ObservedObject
    private var pillarViewModel = PillarViewModel(gap: Config.defaultPillarGap,
                                                  width: Config.defaultPillarWidth,
                                                  moveUnit: Config.defaultPillarMoveUnit)
    
    @Published
    var birdOffsetY: CGFloat = 0
    
    @Published
    var pillarOffsetX: CGFloat = 0
    
    @Published
    var pillarGap: CGFloat = 200
    
    @Published
    var upperPillarHeight: CGFloat = 0
    
    @Published
    var lowerPillarHeight: CGFloat = 0
    
    @Published
    var pillarWidth: CGFloat = 50
    
    private var isScoringCurrentPillars = false
    private var displayLinkSubscription: AnyCancellable?
    
    var birdFrame: CGRect?
    var upperPillarFrame: CGRect?
    var lowerPillarFrame: CGRect?
    
    init() {
        upperPillarHeight = pillarViewModel.upperPillarFrame.height
        lowerPillarHeight = pillarViewModel.lowerPillarFrame.height
    }
    
    func makeBirdFlap() {
        birdViewModel.flap()
    }
    
    func startGame() {
        subscribeToDisplayLink()
    }
    
    func stopGame() {
        displayLinkSubscription?.cancel()
    }
    
    func restartGame() {
        stopGame()
        resetParameters()
        startGame()
    }
    
    private func resetParameters() {
        isGameOver = false
        pillarGap = Config.defaultPillarGap
        pillarWidth = Config.defaultPillarWidth
        birdOffsetY = 0
        pillarOffsetX = 0
        score = 0
        pillarViewModel = PillarViewModel(gap: Config.defaultPillarGap,
                                          width: Config.defaultPillarWidth)
        upperPillarHeight = pillarViewModel.upperPillarFrame.height
        lowerPillarHeight = pillarViewModel.lowerPillarFrame.height
    }
        
}

// MARK: - Helpers
extension GameController {
    
    private func subscribeToDisplayLink() {
        displayLinkSubscription = DisplayLink.shared.sink { [weak self] _ in
            guard let self = self else { return }
            
            if self.isBirdHittingThePillars || self.isBirdHittingTheGround {
                self.isGameOver = true
                self.stopGame()
            }
            
            if self.isPointScored, !self.isScoringCurrentPillars {
                self.score += 1
                self.isScoringCurrentPillars = true
            }
            
            if self.shouldResetPillars {
                let gap = CGFloat.random(in: 200...400)
                let width = CGFloat.random(in: 50...200)
                self.pillarViewModel = PillarViewModel(gap: gap,
                                                       width: width,
                                                       moveUnit: Config.defaultPillarMoveUnit)
                self.pillarWidth = width
                self.pillarGap = gap
                self.isScoringCurrentPillars = false
            }
            
            self.birdViewModel.drop()
            self.pillarViewModel.move()
            self.birdOffsetY = self.birdViewModel.offsetY
            self.pillarOffsetX = self.pillarViewModel.offsetX
        }
    }
    
    private var isBirdHittingThePillars: Bool {
        if let birdFrame = self.birdFrame, let upperPillarFrame = self.upperPillarFrame,
           let lowerPillarFrame = self.lowerPillarFrame {
            return upperPillarFrame.intersects(birdFrame)
                || lowerPillarFrame.intersects(birdFrame)
        }
        return false
    }
    
    private var isBirdHittingTheGround: Bool {
        return birdOffsetY + Config.defaultBirdWidth / 2 >= halfScreenHeight
    }
    
    private var shouldResetPillars: Bool {
        return Config.defaultPillarWidth - pillarOffsetX >= halfScreenHeight
    }
    
    private var isPointScored: Bool {
        if let birdFrame = birdFrame, let upperPillarFrame = upperPillarFrame {
            return upperPillarFrame.maxX < birdFrame.minX
        }
        return false
    }
    
}
