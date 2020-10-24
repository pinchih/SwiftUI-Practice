//
//  BirdViewModel.swift
//  SwiftUI-Practice
//
//  Created by Pin-Chih Lin on 10/21/20.
//

import SwiftUI

final class BirdViewModel: ObservableObject {
    
    private let dropUnit: CGFloat
    private let flapUnit: CGFloat
    @Published var offsetY: CGFloat = 0
    
    init(dropUnit: CGFloat = 2, flapUnit: CGFloat = 50) {
        self.dropUnit = dropUnit
        self.flapUnit = flapUnit
    }
        
    func flap() {
        offsetY -= flapUnit
    }
    
    func drop() {
        offsetY += dropUnit
    }
    
}
