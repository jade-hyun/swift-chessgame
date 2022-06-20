//
//  chessgameTests.swift
//  chessgameTests
//
//  Created by jade.h on 2022/06/20.
//

import XCTest
@testable import chessgame

class chessgameTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testBoardScore() throws {
        let board1 = Board()
        try board1.add(piece: Pawn(color: .black), to: .init(x: 0, y: 1))
        try board1.add(piece: Pawn(color: .black), to: .init(x: 1, y: 1))
        try board1.add(piece: Pawn(color: .black), to: .init(x: 2, y: 1))

        XCTAssertEqual(board1.allScore(), "white: 0\nblack: 3")

        let board2 = Board()
        try board2.add(piece: Pawn(color: .white), to: .init(x: 0, y: 1))
        try board2.add(piece: Pawn(color: .white), to: .init(x: 1, y: 1))
        try board2.add(piece: Pawn(color: .white), to: .init(x: 2, y: 1))

        XCTAssertEqual(board2.allScore(), "white: 3\nblack: 0")

        let board3 = Board()
        try board3.add(piece: Pawn(color: .white), to: .init(x: 0, y: 1))
        try board3.add(piece: Pawn(color: .black), to: .init(x: 1, y: 1))
        try board3.add(piece: Pawn(color: .white), to: .init(x: 2, y: 1))

        XCTAssertEqual(board3.allScore(), "white: 2\nblack: 1")

        let board4 = Board()
        try board4.add(piece: Pawn(color: .white), to: .init(x: 0, y: 1))
        try board4.add(piece: Bishop(color: .black), to: .init(x: 1, y: 1))
        try board4.add(piece: Queen(color: .white), to: .init(x: 2, y: 1))
        try board4.add(piece: Pawn(color: .black), to: .init(x: 3, y: 1))

        XCTAssertEqual(board4.allScore(), "white: 10\nblack: 4")
    }

}
