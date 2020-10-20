//
//  GridView.swift
//  SwiftUI-Practice
//
//  Created by Pin-Chih Lin on 10/16/20.
//

import SwiftUI

struct GridView: View {
    let row: Int
    let column: Int
    
    var body: some View {
        baseView()
    }
}

// MARK: - UI Helpers
extension GridView {
    
    private func overlay() -> some View {
        GeometryReader { geometry in
            Color.clear.preference(key: GridDataPreferenceKey.self,
                                   value: [GridData(row: row,
                                                    column: column,
                                                    frame: geometry.frame(in: .global))])
        }
    }
    
    private func baseView() -> some View {
        Rectangle().overlay(overlay())
    }

}

// MARK: - Preview
struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        GridView(row: 0, column: 0)
            .frame(width: 100, height: 100, alignment: .center)
            .previewDevice("iPhone XR")
    }
}
