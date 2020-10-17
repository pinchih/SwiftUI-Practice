//
//  CardViewContentView.swift
//  SwiftUI-Practice
//
//  Created by Pin-Chih Lin on 10/15/20.
//

import SwiftUI

enum DragState {
    
    case inactive
    case active(translation: CGSize)
    
    var isActive: Bool {
        switch self {
        case .inactive:
            return false
        case .active:
            return true
        }
    }
    
    var translation: CGSize {
        switch self {
        case .inactive:
            return .zero
        case .active(let translation):
            return translation
        }
    }
    
}

struct CardViewContentView: View {

    @State private var isExpanded = false
    
    private let numberOfCards: Int
    private let colors: [Color]
    private let viewModels: [PokerCardViewModel]
    
    init(numberOfCards: Int) {
        self.numberOfCards = numberOfCards
        self.colors = (0..<numberOfCards).map({ _ in .randomColor })
        self.viewModels = (0..<numberOfCards).map({ _ in
            let suit = PokerCard.Suit.allCases.randomElement() ?? .clubs
            let number = PokerCard.Value.allCases.randomElement() ?? .ace
            let pokerCard = PokerCard(suit: suit, value: number)
            return PokerCardViewModel(pokerCard)
        })
    }
    
    var body: some View {
        VStack {
            Spacer()
            cardViews()
            Spacer()
        }
    }
    
}

// MARK: - UI Helpers
extension CardViewContentView {
    
    private func cardView(for index: Int, color: Color) -> some View {
        let degrees = isExpanded ? Double(index - numberOfCards / 2) * 10 : 0
        return CardView(color: colors[index], viewModel: viewModels[index])
            .rotationEffect(Angle(degrees: degrees), anchor: .bottom)
    }
    
    private func cardViews() -> some View {
        ZStack {
            ForEach(0..<numberOfCards) { index in
                cardView(for: index, color: colors[index])
            }
        }
        .onTapGesture { isExpanded.toggle() }
        .animation(.spring(response: 0.4, dampingFraction: 0.825, blendDuration: 0))
    }
    
}


// MARK: - Preview
struct CardViewContentView_Previews: PreviewProvider {
    static var previews: some View {
        CardViewContentView(numberOfCards: 5)
            .previewDevice("iPhone XR")
            .ignoresSafeArea()
    }
}
