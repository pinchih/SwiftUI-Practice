//
//  GridData.swift
//  SwiftUI-Practice
//
//  Created by Pin-Chih Lin on 10/20/20.
//

import Foundation
import SwiftUI

struct GridData: Equatable {
    let row: Int
    let column: Int
    let frame: CGRect
}

struct GridDataPreferenceKey: PreferenceKey {
    static var defaultValue: [GridData] = []
    static func reduce(value: inout [GridData], nextValue: () -> [GridData]) {
        value.append(contentsOf: nextValue())
    }
}
