//
//  PokerCard.swift
//  SwiftUI-Practice
//
//  Created by Pin-Chih Lin on 10/15/20.
//

import Foundation

struct PokerCard {
    
    enum Suit: String, CaseIterable {
        case hearts = "♥"
        case spades = "♠"
        case clubs = "♣"
        case diamonds = "♦"
    }

    enum Value: String, CaseIterable {
        case ace = "A"
        case two = "2"
        case three = "3"
        case four = "4"
        case five = "5"
        case six = "6"
        case seven = "7"
        case eight = "8"
        case nine = "9"
        case ten = "10"
        case jack = "J"
        case queen = "Q"
        case king = "K"
    }
    
    let suit: PokerCard.Suit
    let value: PokerCard.Value
    
}
