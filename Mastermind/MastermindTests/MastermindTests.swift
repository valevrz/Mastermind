//
//  MastermindTests.swift
//  MastermindTests
//
//  Created by Virzi, Valeria (SE-5/7AFI2) on 18.04.23.
//

import XCTest
@testable import Mastermind
import SwiftUI

final class MastermindTests: XCTestCase {

    func test_resetGrayCirclesSuccessfull() throws {
        let viewModel = MastermindViewModel()
        viewModel.resetColors()
        let grayCircles = viewModel.grayCircles

        for row in grayCircles {
            for color in row {
                XCTAssertEqual(color, .gray)
            }
        }
    }

    func test_resetFeedbackCirclesSuccessfull() throws {
        let viewModel = MastermindViewModel()
        viewModel.resetColors()
        let feedbackCircles = viewModel.feedbackCircles

        for row in feedbackCircles {
            for color in row {
                XCTAssertEqual(color, .black)
            }
        }
    }

    func test_newGameSuccessfull() throws{
        let viewModel = MastermindViewModel()
        viewModel.newGame()

        XCTAssertFalse(viewModel.colorCode.isEmpty)

        XCTAssertEqual(viewModel.currentRowIndex, 11)
        XCTAssertFalse(viewModel.isGameOver)
        XCTAssertFalse(viewModel.wonGame)
        XCTAssertFalse(viewModel.lostGame)
    }

    func test_getCircleColorsForRow(){
        let viewModel = MastermindViewModel()
        let row = 11
        let grayCirclesRow = viewModel.getCircleColorsForRow(row)

        XCTAssertFalse(grayCirclesRow.isEmpty)
        XCTAssertEqual(grayCirclesRow.count, 4)
        XCTAssertEqual(grayCirclesRow, viewModel.grayCircles[row])
    }

    func test_setColorSuccessfull(){
        let viewModel = MastermindViewModel()
        let row = 5
        let column = 2
        let color = Color.red

        viewModel.setColor(color, row: row, column: column)
        XCTAssertEqual(viewModel.grayCircles[row], [.gray, .gray, .red, .gray])
    }

    func test_selectColorSuccessfull(){
        let viewModel = MastermindViewModel()
        let row = 5
        let column = 2
        let color = Color.red

        viewModel.selectColor(color, forRow: row, column: column)
        XCTAssertEqual(viewModel.grayCircles[row][column], color)
    }

    func test_getFeedbackCircleColorsForRowSuccessfull(){
        let viewModel = MastermindViewModel()
        let row = 11
        let feedbackCirclesRow = viewModel.getFeedbackCircleColorsForRow(row)

        XCTAssertFalse(feedbackCirclesRow.isEmpty)
        XCTAssertEqual(feedbackCirclesRow.count, 4)
        XCTAssertEqual(feedbackCirclesRow, viewModel.feedbackCircles[row])
    }

    func test_calculateFeedbackSuccessfull(){
        let viewModel = MastermindViewModel()
        let colorCode: [Color] = [.red, .blue, .yellow, .red]

        viewModel.colorCode = colorCode

        let guess : [Color] = [.yellow, .red, .purple, .red]
        viewModel.grayCircles[11] = guess

        var feedback = Feedback(size: 4)
        feedback.addInfo(infos: .correct)
        feedback.addInfo(infos: .wrongPlace)
        feedback.addInfo(infos: .wrongPlace)
        feedback.addInfo(infos: .wrong)

        let calculatedFeedback = viewModel.calculateFeedback()
        XCTAssertEqual(feedback.colors, calculatedFeedback.colors)
    }

    func test_submitGuessWin(){
        let viewModel = MastermindViewModel()

        viewModel.colorCode = [.red, .yellow, .blue, .blue]
        viewModel.grayCircles[11] = [.red, .yellow, .blue, .blue]

        viewModel.submitGuess()

        XCTAssertTrue(viewModel.isGameOver)
        XCTAssertTrue(viewModel.wonGame)
        XCTAssertFalse(viewModel.lostGame)
    }

    func test_submitGuess(){
        let viewModel = MastermindViewModel()

        viewModel.colorCode = [.blue, .yellow, .yellow, .red]
        viewModel.grayCircles[0] = [.red, .blue, .red, .yellow]
        viewModel.currentRowIndex = 0

        viewModel.submitGuess()

        XCTAssertEqual(viewModel.currentRowIndex, -1)
        XCTAssertTrue(viewModel.lostGame)
        XCTAssertTrue(viewModel.isGameOver)
    }
}
