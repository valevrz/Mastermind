//
//  ColorCodeView.swift
//  Mastermind
//
//  Created by Virzi, Valeria (SE-5/7AFI2) on 19.04.23.
//

import SwiftUI

struct ColorCodeView: View {
    let colorCode: [Color]

    var body: some View {
        VStack {
            // Display only one row
            ForEach(0..<1) { rowIndex in
                HStack {
                    // Display 4 colored circles
                    ForEach(0..<4) { columnIndex in
                        if rowIndex < colorCode.count { // check if the current index is valid
                            Circle()
                                .foregroundColor(colorCode[columnIndex])
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
    }
}

struct ColorCodeView_Previews: PreviewProvider {
    static var previews: some View {
        ColorCodeView(colorCode: [.indigo, .purple, .blue, .green])
    }
}
