//
//  MastermindView.swift
//  Mastermind
//
//  Created by Virzi, Valeria (SE-5/7AFI2) on 19.04.23.
//

import SwiftUI

struct MastermindView: View {
    let circleColors: [Color]

    var body: some View {
        HStack {
            ForEach(0..<4) { index in
                Circle()
                    .foregroundColor(circleColors.indices.contains(index) ? circleColors[index] : .gray)
                    .overlay(Circle().stroke(Color.black, lineWidth: 2))
                    .frame(width: 40, height: 40)
            }
        }
    }
}

struct MastermindView_Previews: PreviewProvider {
    static var previews: some View {
        MastermindView(circleColors: [.indigo, .purple, .blue, .green])
    }
}
