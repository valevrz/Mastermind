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
    @Published var randomColors = [Color]()

    init() {
        newGame()
    }

    func resetColors() {
        grayCircles = Array(repeating: Array(repeating: .gray, count: 4), count: 12)
    }

    func newGame() {
        colorCode = [Color]()
        for _ in 0...4 {
            randomColors = colors.shuffled()
            colorCode.append(randomColors[0])
        }
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

struct PurpleButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.title3)
            .bold()
            .foregroundColor(.white)
            .padding(.vertical, 10)
            .padding(.horizontal, 20)
            .background(Color.purple)
            .cornerRadius(10)
            .padding(.top, 10)
    }
}
