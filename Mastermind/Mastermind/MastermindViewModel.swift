//
//  MastermindViewModel.swift
//  Mastermind
//
//  Created by Virzi, Valeria (SE-5/7AFI2) on 19.04.23.
//

import Foundation
import SwiftUI

class MastermindViewModel: ObservableObject {
    let colors: [Color] = [.red, .green, .blue, .yellow, .purple, .indigo]
    @Published var circleColors: [Color] = []

    init() {
        newGame()
    }

    func newGame() {
        circleColors = colors.shuffled()
    }
}
