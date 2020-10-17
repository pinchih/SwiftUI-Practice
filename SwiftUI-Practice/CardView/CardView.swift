//
//  CardView.swift
//  SwiftUI-Practice
//
//  Created by Pin-Chih Lin on 10/15/20.
//

import SwiftUI

private extension CGSize {
    static let cardViewDefultSize = CGSize(width: 200, height: 300)
}

struct CardView: View {
    
    @GestureState private var dragState: DragState = .inactive
    @State private var isSelected = false
    
    private let color: Color
    private let viewModel: PokerCardViewModel
    private let size: CGSize
    
    init(size: CGSize = .cardViewDefultSize,
         color: Color,
         viewModel: PokerCardViewModel) {
        
        self.size = size
        self.color = color
        self.viewModel = viewModel
    }
    
    private var dragGesture: GestureStateGesture<DragGesture,DragState> {
        DragGesture().updating($dragState) { (value, dragState , _) in
            dragState = .active(translation: value.translation)
        }
    }
    
    private var offset: CGSize {
        switch (dragState.isActive, isSelected) {
        case (true, _):
            return dragState.translation
        case (false, false):
            return .zero
        case (false, true):
            return CGSize(width: 0, height: -80)
        }
    }
    
    var body: some View {
        ZStack {
            baseView
        }
    }
    
}

// MARK: - UI
extension CardView {
    
    private var baseView: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(width: 200, height: 300)
            .foregroundColor(color)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.white, lineWidth: isSelected ? 3 : 0)
            )
            .overlay(
                textOverlayView
            )
            .offset(offset)
            .onTapGesture(count: 2) {
                isSelected.toggle()
            }
            .gesture(dragGesture)
    }
    
    private func textView(withText text: String) -> some View {
        Text(text)
            .font(.title)
            .foregroundColor(.white)
    }
    
    private var textOverlayView: some View {
        VStack {
            HStack {
                VStack {
                    textView(withText: viewModel.number)
                    textView(withText: viewModel.suit)
                }.padding()
                Spacer()
            }
            Spacer()
            HStack {
                Spacer()
                VStack {
                    textView(withText: viewModel.number)
                    textView(withText: viewModel.suit)
                }
                .padding()
                .rotationEffect(Angle(degrees: 180))
            }
        }
    }
    
}

// MARK: - Preview
struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(color: .red,
                 viewModel: PokerCardViewModel(.init(suit: .spades, value: .ace)))
            .previewDevice("iPhone XR")
    }
}
