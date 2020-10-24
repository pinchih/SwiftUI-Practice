//
//  PillarViewModel.swift
//  SwiftUI-Practice
//
//  Created by Pin-Chih Lin on 10/21/20.
//

import Foundation
import SwiftUI

final class PillarViewModel: ObservableObject {
    
    private(set) var upperPillarFrame: CGRect
    private(set) var lowerPillarFrame: CGRect
    private let moveUnit: CGFloat
        
    @Published var offsetX: CGFloat = UIScreen.main.bounds.maxX / 2 + 15
    
    init(gap: CGFloat = 50, width: CGFloat = 50, moveUnit: CGFloat = 3) {
        let screenHeight = UIScreen.main.bounds.height
        let upperPillarHeight = 20 + CGFloat.random(in: 0...(screenHeight * 3 / 4))
        let lowerPillarHeight = screenHeight - upperPillarHeight - gap
        upperPillarFrame = CGRect(x: 0, y: 0, width: width, height: upperPillarHeight)
        lowerPillarFrame = CGRect(x: 0, y: upperPillarHeight + gap,
                                  width: width, height: lowerPillarHeight)
        self.moveUnit = moveUnit
    }
    
    func move() {
        offsetX -= moveUnit
    }

}
