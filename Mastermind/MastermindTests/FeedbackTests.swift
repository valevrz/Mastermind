//
//  FeedbackTests.swift
//  MastermindTests
//
//  Created by Virzi, Valeria (SE-5/7AFI2) on 17.05.23.
//

import XCTest
@testable import Mastermind

final class FeedbackTests: XCTestCase {

    func test_isWonSuccessfull() throws {
        var feedback = Feedback(size: 4)
        feedback.state = .init(repeating: .correct, count: 4)
        let sut = feedback.isWon()
        XCTAssertTrue(sut)
    }

    func test_isWonFalse() throws {
        var feedback = Feedback(size: 4)
        feedback.state = .init(repeating: .wrong, count: 4)
        let sut = feedback.isWon()
        XCTAssertFalse(sut)
    }

    func test_colorsRed() {
        var feedback = Feedback(size: 4)
        feedback.state = .init(repeating: .correct, count: 4)
        let sut = feedback.colors
        XCTAssertEqual(sut, [.red, .red, .red, .red])
    }

    func test_colorsGeneral() {
        var feedback = Feedback(size: 3)
        feedback.state = [.correct, .wrongPlace, .wrong]
        let sut = feedback.colors
        XCTAssertEqual(sut, [.red, .white, .gray])
    }

}
