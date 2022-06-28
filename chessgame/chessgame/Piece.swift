//
//  Piece.swift
//  chessgame
//
//  Created by jade.h on 2022/06/20.
//

import Foundation

enum PieceColor: CaseIterable {
    case white
    case black
}

protocol Piece {
    static var score: Int { get }
    static var maxCount: Int { get }

    var color: PieceColor { get }
    var symbol: Character { get }
    var paths: [[Position]] { get }

    func availables(for currentPosition: Position, boardSize: Int) -> [(path: [Position], finalPosition: Position)]
}

extension Piece {
    func availables(for currentPosition: Position, boardSize: Int) -> [(path: [Position], finalPosition: Position)] {
        return paths.map { path in
            return (path, path.reduce(currentPosition, +))
        }.filter { _, finalPosition in
            return finalPosition.isInBoard(boardSize)
        }
    }
}

struct Position: Hashable {
    let file: Int
    let rank: Int

    init(file: Int, rank: Int) {
        self.file = file
        self.rank = rank
    }

    init(file: Character, rank: Int) {
        self.file = Int((file.uppercased().utf8.first ?? 65) - 64)
        self.rank = rank
    }

    func isInBoard(_ boardSize: Int) -> Bool {
        return 1...boardSize ~= file && 1...boardSize ~= rank
    }
}

extension Position {
    static let up: Position = .init(file: 0, rank: -1)
    static let down: Position = .init(file: 0, rank: 1)
    static let left: Position = .init(file: -1, rank: 0)
    static let right: Position = .init(file: 1, rank: 0)
    static let leftUp: Position = .left + .up
    static let leftDown: Position = .left + .down
    static let rightUp: Position = .right + .up
    static let rightDown: Position = .right + .down
}

extension Position: Comparable {
    static func < (lhs: Position, rhs: Position) -> Bool {
        if lhs.rank == rhs.rank {
            return lhs.file < rhs.file
        }

        return lhs.rank < rhs.rank
    }

    static func +(lhs: Position, rhs: Position) -> Position {
        return .init(file: lhs.file + rhs.file, rank: lhs.rank + rhs.rank)
    }
}

struct Pawn: Piece {
    static let score = 1
    static let maxCount = 8

    let color: PieceColor

    var symbol: Character {
        switch color {
        case .white:
            return "♙"
        case .black:
            return "♟"
        }
    }

    var paths: [[Position]] {
        switch color {
        case .white:
            return [[.up]]
        case .black:
            return [[.down]]
        }
    }
}

struct Knight: Piece {
    static let score = 3
    static let maxCount = 2

    let color: PieceColor

    var symbol: Character {
        switch color {
        case .white:
            return "♘"
        case .black:
            return "♞"
        }
    }

    var paths: [[Position]] {
        return [
            [.up, .leftUp],
            [.up, .rightUp],
            [.right, .rightUp],
            [.right, .rightDown],
            [.down, .rightDown],
            [.down, .leftDown],
            [.left, .leftUp],
            [.left, .leftDown]
        ]
    }
}

struct Bishop: Piece {
    static let score = 3
    static let maxCount = 2

    let color: PieceColor

    var symbol: Character {
        switch color {
        case .white:
            return "♗"
        case .black:
            return "♝"
        }
    }

    var paths: [[Position]] {
        return [
            [.rightDown],
            [.rightDown, .rightDown],
            [.rightDown, .rightDown, .rightDown],
            [.rightDown, .rightDown, .rightDown, .rightDown],
            [.rightDown, .rightDown, .rightDown, .rightDown, .rightDown],
            [.rightDown, .rightDown, .rightDown, .rightDown, .rightDown, .rightDown],
            [.rightDown, .rightDown, .rightDown, .rightDown, .rightDown, .rightDown, .rightDown],
            [.rightUp],
            [.rightUp, .rightUp],
            [.rightUp, .rightUp, .rightUp],
            [.rightUp, .rightUp, .rightUp, .rightUp],
            [.rightUp, .rightUp, .rightUp, .rightUp, .rightUp],
            [.rightUp, .rightUp, .rightUp, .rightUp, .rightUp, .rightUp],
            [.rightUp, .rightUp, .rightUp, .rightUp, .rightUp, .rightUp, .rightUp],
            [.leftDown],
            [.leftDown, .leftDown],
            [.leftDown, .leftDown, .leftDown],
            [.leftDown, .leftDown, .leftDown, .leftDown],
            [.leftDown, .leftDown, .leftDown, .leftDown, .leftDown],
            [.leftDown, .leftDown, .leftDown, .leftDown, .leftDown, .leftDown],
            [.leftDown, .leftDown, .leftDown, .leftDown, .leftDown, .leftDown, .leftDown],
            [.leftUp],
            [.leftUp, .leftUp],
            [.leftUp, .leftUp, .leftUp],
            [.leftUp, .leftUp, .leftUp, .leftUp],
            [.leftUp, .leftUp, .leftUp, .leftUp, .leftUp],
            [.leftUp, .leftUp, .leftUp, .leftUp, .leftUp, .leftUp],
            [.leftUp, .leftUp, .leftUp, .leftUp, .leftUp, .leftUp, .leftUp]
        ]
    }
}

struct Rook: Piece {
    static let score = 5
    static let maxCount = 2

    let color: PieceColor

    var symbol: Character {
        switch color {
        case .white:
            return "♖"
        case .black:
            return "♜"
        }
    }

    var paths: [[Position]] {
        return [
            [.up],
            [.up, .up],
            [.up, .up, .up],
            [.up, .up, .up, .up],
            [.up, .up, .up, .up, .up],
            [.up, .up, .up, .up, .up, .up],
            [.up, .up, .up, .up, .up, .up, .up],
            [.right],
            [.right, .right],
            [.right, .right, .right],
            [.right, .right, .right, .right],
            [.right, .right, .right, .right, .right],
            [.right, .right, .right, .right, .right, .right],
            [.right, .right, .right, .right, .right, .right, .right],
            [.down],
            [.down, .down],
            [.down, .down, .down],
            [.down, .down, .down, .down],
            [.down, .down, .down, .down, .down],
            [.down, .down, .down, .down, .down, .down],
            [.down, .down, .down, .down, .down, .down, .down],
            [.left],
            [.left, .left],
            [.left, .left, .left],
            [.left, .left, .left, .left],
            [.left, .left, .left, .left, .left],
            [.left, .left, .left, .left, .left, .left],
            [.left, .left, .left, .left, .left, .left, .left]
        ]
    }
}

struct Queen: Piece {
    static let score = 9
    static let maxCount = 1
    
    let color: PieceColor

    var symbol: Character {
        switch color {
        case .white:
            return "♕"
        case .black:
            return "♛"
        }
    }

    var paths: [[Position]] {
        return Bishop(color: color).paths + Rook(color: color).paths
    }
}
