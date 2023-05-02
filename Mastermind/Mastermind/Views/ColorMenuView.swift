//
//  ColorMenuView.swift
//  Mastermind
//
//  Created by Virzi, Valeria (SE-5/7AFI2) on 26.04.23.
//

import SwiftUI

struct ColorMenuView: View {
    let colors: [Color]
    @ObservedObject var viewModel: MastermindViewModel
    @Binding var selectedRowIndex: Int
    @Binding var selectedColumnIndex: Int
    @Binding var lockedRows: Int
    @Binding var coloredRowIndex: Int

    var body: some View {
        HStack(spacing: 10) {
            ForEach(colors, id: \.self) { color in
                Button(action: {
                    if selectedRowIndex > lockedRows && selectedRowIndex < coloredRowIndex {
                        viewModel.selectColor(color, forRow: selectedRowIndex, column: selectedColumnIndex)
                    }
                    selectedColumnIndex += 1
                }) {
                    Circle()
                        .fill(color)
                        .frame(width: 35, height: 35)
                        .overlay(Circle().stroke(Color.black, lineWidth: 2))
                }
                .disabled(selectedRowIndex <= lockedRows)
            }
        }
    }
}

struct ColorMenuView_Previews: PreviewProvider {
    @State static var selectedRowIndex: Int = 11
    @State static var selectedColumnIndex: Int = 0
    @State static var lockedRows: Int = 10
    @State static var coloredRowIndex: Int = 12

    static var previews: some View {
        ColorMenuView(colors: [.red, .green, .blue, .yellow, .purple, .indigo], viewModel: MastermindViewModel(), selectedRowIndex: $selectedRowIndex, selectedColumnIndex: $selectedColumnIndex, lockedRows: $lockedRows, coloredRowIndex: $coloredRowIndex)
    }
}
