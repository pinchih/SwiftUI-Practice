//
//  Color+Extension.swift
//  SwiftUI-Practice
//
//  Created by Pin-Chih Lin on 10/15/20.
//

import SwiftUI

extension Color {
    
    static var randomColor: Color {
        let red = Double.random(in: 0...255) / 255
        let green = Double.random(in: 0...255) / 255
        let blue = Double.random(in: 0...255) / 255
        return Color(red: red, green: green, blue: blue)
    }
    
}
