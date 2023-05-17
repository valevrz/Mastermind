//
//  MastermindViewModel.swift
//  Mastermind
//
//  Created by Virzi, Valeria (SE-5/7AFI2) on 19.04.23.
//

import Foundation
import SwiftUI

struct Feedback {
    enum Infos {
        case correct
        case wrongPlace
        case wrong
    }

    var state: [Infos]
    private let size: Int

    init(size: Int = 4) {
        self.size = size
        self.state = []
    }

    var colors: [Color] {state.map({
        switch $0{
        case .correct :
            return .red
        case .wrongPlace :
            return .white
        case .wrong :
            return .gray
        }
    })}
    
    func isWon() -> Bool {
        state.allSatisfy({$0 == .correct})
    }

    mutating func addInfo(infos: Infos) {
        state.append(infos)
    }
}

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
    @Published var wonGame = false
    @Published var lostGame = false

    init() {
        newGame()
    }

    func resetColors() {
        let columnCount = 4
        grayCircles = Array(repeating: Array(repeating: .gray, count: columnCount), count: 12)
        feedbackCircles = Array(repeating: Array(repeating: .black, count: columnCount), count: 12)
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
        wonGame = false
        lostGame = false
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

    func calculateFeedback() -> Feedback {
        remainingGuess = []
        remainingColorCode = colorCode
        let size = 4
        var feedback = Feedback(size: size)

        // Zähle die korrekten Farben an der richtigen Stelle
        for i in 0..<4 {
            if grayCircles[currentRowIndex][i] == colorCode[i] {
                feedback.addInfo(infos: .correct)
                remainingColorCode[i] = .gray
            } else {
                remainingGuess.append(grayCircles[currentRowIndex][i])
            }
        }

        // Zähle die korrekten Farben an der falschen Stelle
        for i in 0..<4 {
            if remainingGuess.contains(remainingColorCode[i]) {
                feedback.addInfo(infos: .wrongPlace)

            }
        }
        // Zähle die falschen Farben
        for _ in 0..<(size-feedback.state.count){
            feedback.addInfo(infos: .wrong)
        }

        return feedback
    }

    func submitGuess() {
        guard !isGameOver else { return }

        // Füge die Farben der aktuellen Reihe zum Feedback hinzu
        let feedback = calculateFeedback()
        feedbackCircles[currentRowIndex] = feedback.colors

        // Überprüfe, ob das Spiel gewonnen wurde
        if feedback.isWon() {
            isGameOver = true
            wonGame = true
        }

        // Inkrementiere den Index für die aktuelle Reihe
        currentRowIndex -= 1

        // Wenn alle Reihen ausgewählt wurden, ist das Spiel verloren
        if currentRowIndex == -1 {
            isGameOver = true
            lostGame = true
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
