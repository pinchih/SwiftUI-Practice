//
//  GridViewViewModel.swift
//  SwiftUI-Practice
//
//  Created by Pin-Chih Lin on 10/20/20.
//

import Foundation
import SwiftUI

struct GridPoint: Equatable, Hashable {
    let row: Int
    let column: Int
}

class GridViewViewModel: ObservableObject {
    
    @Published var dragging = Set<GridPoint>()
    
    var frameMap = [GridPoint: CGRect]()
    
    let numberOfColumns: Int
    let numberOfRows: Int
    
    let gridWidth: CGFloat
    
    var gridHeight: CGFloat {
        return gridWidth
    }
    
    var colors = [[Color]]()
    
    init(numberOfColumns: Int) {
        self.numberOfColumns = numberOfColumns
        let screenSize = UIScreen.main.bounds.size
        let width = screenSize.width / CGFloat(numberOfColumns)
        self.numberOfRows = Int(screenSize.height / width)
        self.gridWidth = width
        for _ in 0..<numberOfRows {
            var column = [Color]()
            for _ in 0..<numberOfColumns {
                column.append(.randomColor)
            }
            colors.append(column)
        }
    }
    
}

// MARK: - Helpers
extension GridViewViewModel {
    
    private func isGridInDragging(_ row: Int, _ column: Int) -> Bool {
        dragging.contains(.init(row: row, column: column))
    }
    
    func overlayScaleEffect(_ row: Int, _ column: Int) -> CGSize {
        let isDragging = isGridInDragging(row, column)
        return CGSize(width: isDragging ? 0.8 : 0.5, height: isDragging ? 0.8 : 0.5)
    }
    
    func overlayForegroundColor(_ row: Int, _ column: Int) -> Color {
        let isDragging = isGridInDragging(row, column)
        return isDragging ? colors[row][column] : Color.white
    }
    
}
