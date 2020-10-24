//
//  BirdView.swift
//  SwiftUI-Practice
//
//  Created by Pin-Chih Lin on 10/22/20.
//

import SwiftUI

struct FramePreferenceKey: PreferenceKey {
    static func reduce(value: inout CGRect?, nextValue: () -> CGRect?) {
        value = value ?? nextValue()
    }
}

struct BirdView: View {
    
    var body: some View {
        Rectangle()
            .cornerRadius(10)
            .foregroundColor(.blue)            
            .overlay(GeometryReader { geometry in
                Color.clear.preference(key: FramePreferenceKey.self,
                                       value: geometry.frame(in: .global))
            })
            .animation(.default)
    }
    
}
