//
//  GrayCircleView.swift
//  Mastermind
//
//  Created by Virzi, Valeria (SE-5/7AFI2) on 18.04.23.
//

import SwiftUI
import Foundation

struct GrayCircleView: View {
    var body: some View {
        Circle()
            .fill(Color.gray)
            .overlay(Circle().stroke(Color.black, lineWidth: 2))
            .frame(width: 40, height: 40)
    }
}

struct GrayCircleView_Previews: PreviewProvider {
    static var previews: some View {
        GrayCircleView()
    }
}
