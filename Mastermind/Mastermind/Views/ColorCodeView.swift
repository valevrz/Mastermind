//
//  ColorCodeView.swift
//  Mastermind
//
//  Created by Virzi, Valeria (SE-5/7AFI2) on 19.04.23.
//

import SwiftUI

struct ColorCodeView: View {
    @ObservedObject var viewModel = MastermindViewModel()
    let colorCode: [Color]
    var isGameOver: Bool



    var body: some View {
        let color: [Color] = isGameOver ? colorCode : Array(repeating: .gray, count: viewModel.columnCount)
            // Display only one row
            HStack {
                // Display 4 colored circles
                ForEach(0..<viewModel.columnCount) { columnIndex in
                    if columnIndex < colorCode.count { // check if the current index is valid
                        Circle()
                            .foregroundColor(color[columnIndex])
                            .overlay(Circle().stroke(Color.black, lineWidth: 2))
                            .frame(width: 40, height: 40)
                    }else{
                        // Display a gray circle if there is no color in the array
                        GrayCircleView()
                    }
                }
            }
    }
}

struct ColorCodeView_Previews: PreviewProvider {
    static var previews: some View {
        ColorCodeView(colorCode: [.indigo, .purple, .blue, .green, .yellow], isGameOver: false)
        ColorCodeView(colorCode: [.indigo, .purple, .blue, .green, .yellow], isGameOver: true)
    }
}
