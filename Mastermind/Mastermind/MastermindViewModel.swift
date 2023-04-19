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
    @Published var grayCircles = [[Color]]()
    @Published var colorCode = [Color]()
    @Published var selectedColor: Color?

    init() {
        newGame()
    }

    func resetColors() {
        grayCircles = Array(repeating: Array(repeating: .gray, count: 4), count: 12)
    }

    func newGame() {
        colorCode = colors.shuffled()
        resetColors()
    }

    func getCircleColorsForRow(_ row: Int) -> [Color] {
            return grayCircles[row]
        }

    func setColor(_ color: Color, row: Int, column: Int) {
        guard row < grayCircles.count, column < grayCircles[row].count else { return }
        grayCircles[row][column] = color
    }

    func selectColor(_ color: Color, forRow row: Int, column: Int) {
            guard row < grayCircles.count, column < grayCircles[row].count else { return }
            grayCircles[row][column] = color
    }
}
