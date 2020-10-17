//
//  PokerCardViewModel.swift
//  SwiftUI-Practice
//
//  Created by Pin-Chih Lin on 10/15/20.
//

import Foundation

class PokerCardViewModel {
    
    let pokerCard: PokerCard
    
    var number: String {
        return pokerCard.value.rawValue
    }
    
    var suit: String {
        return pokerCard.suit.rawValue
    }    
    
    init(_ pokerCard: PokerCard) {
        self.pokerCard = pokerCard
    }
    
}
