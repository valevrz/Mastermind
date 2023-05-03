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
    @Published var feedbackCircles = [[Color]]()

    var currentRowIndex = 11
    @Published var isGameOver = false

    @Published var feedbackColors = [Color]()
    var remainingGuess = [Color]()
    var remainingColorCode = [Color]()

    init() {
        newGame()
    }

    func resetColors() {
        grayCircles = Array(repeating: Array(repeating: .gray, count: 4), count: 12)
        feedbackCircles = Array(repeating: Array(repeating: .black, count: 4), count: 12)
    }

    func newGame() {
        colorCode = [Color]()
        for _ in 0...4 {
            randomColors = colors.shuffled()
            colorCode.append(randomColors[0])
        }
        resetColors()
        currentRowIndex = 11
        isGameOver = false
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

    func getFeedbackCircleColorsForRow(_ row: Int) -> [Color] {
        guard row < feedbackCircles.count else { return [.gray, .gray, .gray, .gray] }
        return feedbackCircles[row]
    }

    func calculateFeedback() -> [Color] {
        remainingGuess = []
        feedbackColors = []
        remainingColorCode = colorCode
        // Zähle die korrekten Farben an der richtigen Stelle
        for i in 0..<4 {
            if grayCircles[currentRowIndex][i] == colorCode[i] {
                feedbackColors.append(.red)
                remainingColorCode[i] = .gray
            } else {
                remainingGuess.append(grayCircles[currentRowIndex][i])
            }
        }

        // Zähle die korrekten Farben an der falschen Stelle
        for i in 0..<(4-feedbackColors.count) {
            if remainingGuess.contains(remainingColorCode[i]) {
                feedbackColors.append(.white)
            }
        }
        // Zähle die falschen Farben
        for _ in 0..<(4-feedbackColors.count){
            feedbackColors.append(.gray)
        }

        return feedbackColors
    }

    func submitGuess() {
        guard !isGameOver else { return }

        // Überprüfe, ob alle Felder in der aktuellen Reihe ausgewählt wurden
        for column in 0..<4 {
            if grayCircles[currentRowIndex][column] == .gray {
                // Wenn ein Feld nicht ausgewählt wurde, breche ab
                return
            }
        }

        // Füge die Farben der aktuellen Reihe zum Feedback hinzu
        feedbackColors = calculateFeedback()
        feedbackCircles[currentRowIndex] = feedbackColors
//        feedbackCircles.append(feedbackColors)

        // Überprüfe, ob das Spiel gewonnen wurde
        if feedbackColors == [.red, .red, .red, .red] {
            isGameOver = true
        }

        // Inkrementiere den Index für die aktuelle Reihe
        currentRowIndex -= 1

        // Wenn alle Reihen ausgewählt wurden, ist das Spiel verloren
        if currentRowIndex == -1 {
            isGameOver = true
            return
        }
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
