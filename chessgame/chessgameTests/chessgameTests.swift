//
//  chessgameTests.swift
//  chessgameTests
//
//  Created by jade.h on 2022/06/20.
//

import XCTest
@testable import chessgame

class chessgameTests: XCTestCase {

    func test보드에말이있는지() throws {
        let board1 = Board()
        XCTAssertFalse(board1.isPieceExists)

        let board2 = Board()
        try board2.add(piece: Pawn(color: .black), to: .init(file: 1, rank: 1))

        XCTAssertTrue(board2.isPieceExists)
    }

    func testBoardScore() throws {
        let board1 = Board()
        try board1.add(piece: Pawn(color: .black), to: .init(file: 1, rank: 2))
        try board1.add(piece: Pawn(color: .black), to: .init(file: 2, rank: 2))
        try board1.add(piece: Pawn(color: .black), to: .init(file: 3, rank: 2))

        XCTAssertEqual(board1.allScore(), "white: 0\nblack: 3")

        let board2 = Board()
        try board2.add(piece: Pawn(color: .white), to: .init(file: 1, rank: 2))
        try board2.add(piece: Pawn(color: .white), to: .init(file: 2, rank: 2))
        try board2.add(piece: Pawn(color: .white), to: .init(file: 3, rank: 2))

        XCTAssertEqual(board2.allScore(), "white: 3\nblack: 0")

        let board3 = Board()
        try board3.add(piece: Pawn(color: .white), to: .init(file: 1, rank: 2))
        try board3.add(piece: Pawn(color: .black), to: .init(file: 2, rank: 2))
        try board3.add(piece: Pawn(color: .white), to: .init(file: 3, rank: 2))

        XCTAssertEqual(board3.allScore(), "white: 2\nblack: 1")

        let board4 = Board()
        try board4.add(piece: Pawn(color: .white), to: .init(file: 1, rank: 2))
        try board4.add(piece: Bishop(color: .black), to: .init(file: 2, rank: 2))
        try board4.add(piece: Queen(color: .white), to: .init(file: 3, rank: 2))
        try board4.add(piece: Pawn(color: .black), to: .init(file: 4, rank: 2))

        XCTAssertEqual(board4.allScore(), "white: 10\nblack: 4")
    }

    func testBoardDisplay() throws {
        let board1 = Board()
        try board1.add(piece: Pawn(color: .black), to: .init(file: 1, rank: 2))
        try board1.add(piece: Pawn(color: .black), to: .init(file: 2, rank: 2))
        try board1.add(piece: Pawn(color: .black), to: .init(file: 3, rank: 2))

        XCTAssertEqual(board1.display(), "........\n♟♟♟.....\n........\n........\n........\n........\n........\n........")

        let board2 = Board()
        try board2.add(piece: Pawn(color: .black), to: .init(file: 1, rank: 3))
        try board2.add(piece: Bishop(color: .white), to: .init(file: 2, rank: 3))
        try board2.add(piece: Queen(color: .black), to: .init(file: 3, rank: 3))
        try board2.add(piece: Knight(color: .white), to: .init(file: 4, rank: 3))

        XCTAssertEqual(board2.display(), "........\n........\n♟♗♛♘....\n........\n........\n........\n........\n........")
    }

    func test체스말추가제한() throws {
        let board = Board()

        let whitePawn = Pawn(color: .white)
        let blackPawn = Pawn(color: .black)

        let whiteQueen = Queen(color: .white)
        let blackQueen = Queen(color: .black)

        XCTAssertNoThrow(try board.add(piece: whitePawn, to: .init(file: 1, rank: 2)))
        XCTAssertNoThrow(try board.add(piece: whitePawn, to: .init(file: 2, rank: 2)))
        XCTAssertNoThrow(try board.add(piece: whitePawn, to: .init(file: 3, rank: 2)))
        XCTAssertNoThrow(try board.add(piece: whitePawn, to: .init(file: 4, rank: 2)))
        XCTAssertNoThrow(try board.add(piece: whitePawn, to: .init(file: 5, rank: 2)))
        XCTAssertNoThrow(try board.add(piece: whitePawn, to: .init(file: 6, rank: 2)))
        XCTAssertNoThrow(try board.add(piece: whitePawn, to: .init(file: 7, rank: 2)))
        XCTAssertNoThrow(try board.add(piece: whitePawn, to: .init(file: 8, rank: 2)))

        XCTAssertNoThrow(try board.add(piece: blackPawn, to: .init(file: 1, rank: 3)))

        XCTAssertThrowsError(try board.add(piece: whitePawn, to: .init(file: 1, rank: 3)))

        XCTAssertNoThrow(try board.add(piece: whiteQueen, to: .init(file: 4, rank: 1)))

        XCTAssertNoThrow(try board.add(piece: blackQueen, to: .init(file: 4, rank: 8)))

        XCTAssertThrowsError(try board.add(piece: whiteQueen, to: .init(file: 5, rank: 1)))
    }

    func test체스판초기화() throws {
        let board = Board()

        XCTAssertFalse(board.isPieceExists)

        XCTAssertNoThrow(try board.initializePieces())

        XCTAssertTrue(board.isPieceExists)

        XCTAssertEqual(board.display(), "♜♞♝.♛♝♞♜\n♟♟♟♟♟♟♟♟\n........\n........\n........\n........\n♙♙♙♙♙♙♙♙\n♖♘♗.♕♗♘♖")
    }

}
