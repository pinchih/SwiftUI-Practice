//
//  GridViewContentView.swift
//  SwiftUI-Practice
//
//  Created by Pin-Chih Lin on 10/16/20.
//

import SwiftUI

struct GridViewContentView: View {
    
    @GestureState private var draggingLocation: CGPoint?
    @ObservedObject private var viewModel: GridViewViewModel

    init(_ viewModel: GridViewViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        baseView()
    }
    
}

// MARK: - UI Helpers
extension GridViewContentView {
    
    private func baseView() -> some View {
        VStack(spacing: 0) {
            ForEach(0..<viewModel.numberOfRows) { row in
                HStack(spacing: 0) {
                    ForEach(0..<viewModel.numberOfColumns) { column in
                        gridView(row, column: column)
                    }
                }
            }
        }
        .gesture(
            DragGesture(minimumDistance: 0, coordinateSpace: .global)
                .updating($draggingLocation) { (value, state, _) in
                    state = value.location
                    for (point, frame) in viewModel.frameMap where frame.contains(value.location) {
                        viewModel.dragging.insert(point)
                    }
                }
        )
        .onPreferenceChange(GridDataPreferenceKey.self) { preferences in
            for preference in preferences {
                let point = GridPoint(row: preference.row, column: preference.column)
                viewModel.frameMap[point] = preference.frame
            }
        }
        .ignoresSafeArea()
        .onDisappear {
            viewModel.dragging.removeAll()
        }
    }
    
    private func gridView(_ row: Int, column: Int) -> some View {
        GridView(row: row, column: column)
            .frame(width: viewModel.gridWidth, height: viewModel.gridHeight, alignment: .center)
            .foregroundColor(.white)
            .overlay(overlayView(row, column))
    }
    
    private func overlayView(_ row: Int, _ column: Int) -> some View {
        Rectangle()
            .cornerRadius(10)
            .scaleEffect(viewModel.overlayScaleEffect(row, column), anchor: .center)
            .foregroundColor(viewModel.overlayForegroundColor(row, column))
            .animation(.spring())
    }
    
}

// MARK: - Preview
struct GridViewContentView_Previews: PreviewProvider {
    static var previews: some View {
        GridViewContentView(GridViewViewModel(numberOfColumns: 10))
            .previewDevice("iPhone XR")
    }
}
