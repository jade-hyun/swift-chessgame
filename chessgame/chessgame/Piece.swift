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
            return [[.init(file: 0, rank: -1)]]
        case .black:
            return [[.init(file: 0, rank: 1)]]
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
            [.init(file: 0, rank: 1), .init(file: -1, rank: 1)],
            [.init(file: 0, rank: 1), .init(file: 1, rank: 1)],
            [.init(file: 1, rank: 0), .init(file: 1, rank: 1)],
            [.init(file: 1, rank: 0), .init(file: 1, rank: -1)],
            [.init(file: 0, rank: -1), .init(file: 1, rank: -1)],
            [.init(file: 0, rank: -1), .init(file: -1, rank: -1)],
            [.init(file: -1, rank: 0), .init(file: -1, rank: -1)],
            [.init(file: -1, rank: 0), .init(file: -1, rank: 1)]
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
            [.init(file: 1, rank: 1)],
            [.init(file: 1, rank: 1), .init(file: 1, rank: 1)],
            [.init(file: 1, rank: 1), .init(file: 1, rank: 1), .init(file: 1, rank: 1)],
            [.init(file: 1, rank: 1), .init(file: 1, rank: 1), .init(file: 1, rank: 1), .init(file: 1, rank: 1)],
            [.init(file: 1, rank: 1), .init(file: 1, rank: 1), .init(file: 1, rank: 1), .init(file: 1, rank: 1), .init(file: 1, rank: 1)],
            [.init(file: 1, rank: 1), .init(file: 1, rank: 1), .init(file: 1, rank: 1), .init(file: 1, rank: 1), .init(file: 1, rank: 1), .init(file: 1, rank: 1)],
            [.init(file: 1, rank: 1), .init(file: 1, rank: 1), .init(file: 1, rank: 1), .init(file: 1, rank: 1), .init(file: 1, rank: 1), .init(file: 1, rank: 1), .init(file: 1, rank: 1)],
            [.init(file: 1, rank: -1)],
            [.init(file: 1, rank: -1), .init(file: 1, rank: -1)],
            [.init(file: 1, rank: -1), .init(file: 1, rank: -1), .init(file: 1, rank: -1)],
            [.init(file: 1, rank: -1), .init(file: 1, rank: -1), .init(file: 1, rank: -1), .init(file: 1, rank: -1)],
            [.init(file: 1, rank: -1), .init(file: 1, rank: -1), .init(file: 1, rank: -1), .init(file: 1, rank: -1), .init(file: 1, rank: -1)],
            [.init(file: 1, rank: -1), .init(file: 1, rank: -1), .init(file: 1, rank: -1), .init(file: 1, rank: -1), .init(file: 1, rank: -1), .init(file: 1, rank: -1)],
            [.init(file: 1, rank: -1), .init(file: 1, rank: -1), .init(file: 1, rank: -1), .init(file: 1, rank: -1), .init(file: 1, rank: -1), .init(file: 1, rank: -1), .init(file: 1, rank: -1)],
            [.init(file: -1, rank: 1)],
            [.init(file: -1, rank: 1), .init(file: -1, rank: 1)],
            [.init(file: -1, rank: 1), .init(file: -1, rank: 1), .init(file: -1, rank: 1)],
            [.init(file: -1, rank: 1), .init(file: -1, rank: 1), .init(file: -1, rank: 1), .init(file: -1, rank: 1)],
            [.init(file: -1, rank: 1), .init(file: -1, rank: 1), .init(file: -1, rank: 1), .init(file: -1, rank: 1), .init(file: -1, rank: 1)],
            [.init(file: -1, rank: 1), .init(file: -1, rank: 1), .init(file: -1, rank: 1), .init(file: -1, rank: 1), .init(file: -1, rank: 1), .init(file: -1, rank: 1)],
            [.init(file: -1, rank: 1), .init(file: -1, rank: 1), .init(file: -1, rank: 1), .init(file: -1, rank: 1), .init(file: -1, rank: 1), .init(file: -1, rank: 1), .init(file: -1, rank: 1)],
            [.init(file: -1, rank: -1)],
            [.init(file: -1, rank: -1), .init(file: -1, rank: -1)],
            [.init(file: -1, rank: -1), .init(file: -1, rank: -1), .init(file: -1, rank: -1)],
            [.init(file: -1, rank: -1), .init(file: -1, rank: -1), .init(file: -1, rank: -1), .init(file: -1, rank: -1)],
            [.init(file: -1, rank: -1), .init(file: -1, rank: -1), .init(file: -1, rank: -1), .init(file: -1, rank: -1), .init(file: -1, rank: -1)],
            [.init(file: -1, rank: -1), .init(file: -1, rank: -1), .init(file: -1, rank: -1), .init(file: -1, rank: -1), .init(file: -1, rank: -1), .init(file: -1, rank: -1)],
            [.init(file: -1, rank: -1), .init(file: -1, rank: -1), .init(file: -1, rank: -1), .init(file: -1, rank: -1), .init(file: -1, rank: -1), .init(file: -1, rank: -1), .init(file: -1, rank: -1)]
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
            [.init(file: 0, rank: 1)],
            [.init(file: 0, rank: 1), .init(file: 0, rank: 1)],
            [.init(file: 0, rank: 1), .init(file: 0, rank: 1), .init(file: 0, rank: 1)],
            [.init(file: 0, rank: 1), .init(file: 0, rank: 1), .init(file: 0, rank: 1), .init(file: 0, rank: 1)],
            [.init(file: 0, rank: 1), .init(file: 0, rank: 1), .init(file: 0, rank: 1), .init(file: 0, rank: 1), .init(file: 0, rank: 1)],
            [.init(file: 0, rank: 1), .init(file: 0, rank: 1), .init(file: 0, rank: 1), .init(file: 0, rank: 1), .init(file: 0, rank: 1), .init(file: 0, rank: 1)],
            [.init(file: 1, rank: 0)],
            [.init(file: 1, rank: 0), .init(file: 1, rank: 0)],
            [.init(file: 1, rank: 0), .init(file: 1, rank: 0), .init(file: 1, rank: 0)],
            [.init(file: 1, rank: 0), .init(file: 1, rank: 0), .init(file: 1, rank: 0), .init(file: 1, rank: 0)],
            [.init(file: 1, rank: 0), .init(file: 1, rank: 0), .init(file: 1, rank: 0), .init(file: 1, rank: 0), .init(file: 1, rank: 0)],
            [.init(file: 1, rank: 0), .init(file: 1, rank: 0), .init(file: 1, rank: 0), .init(file: 1, rank: 0), .init(file: 1, rank: 0), .init(file: 1, rank: 0)],
            [.init(file: 0, rank: -1)],
            [.init(file: 0, rank: -1), .init(file: 0, rank: -1)],
            [.init(file: 0, rank: -1), .init(file: 0, rank: -1), .init(file: 0, rank: -1)],
            [.init(file: 0, rank: -1), .init(file: 0, rank: -1), .init(file: 0, rank: -1), .init(file: 0, rank: -1)],
            [.init(file: 0, rank: -1), .init(file: 0, rank: -1), .init(file: 0, rank: -1), .init(file: 0, rank: -1), .init(file: 0, rank: -1)],
            [.init(file: 0, rank: -1), .init(file: 0, rank: -1), .init(file: 0, rank: -1), .init(file: 0, rank: -1), .init(file: 0, rank: -1), .init(file: 0, rank: -1)],
            [.init(file: -1, rank: 0)],
            [.init(file: -1, rank: 0), .init(file: -1, rank: 0)],
            [.init(file: -1, rank: 0), .init(file: -1, rank: 0), .init(file: -1, rank: 0)],
            [.init(file: -1, rank: 0), .init(file: -1, rank: 0), .init(file: -1, rank: 0), .init(file: -1, rank: 0)],
            [.init(file: -1, rank: 0), .init(file: -1, rank: 0), .init(file: -1, rank: 0), .init(file: -1, rank: 0), .init(file: -1, rank: 0)],
            [.init(file: -1, rank: 0), .init(file: -1, rank: 0), .init(file: -1, rank: 0), .init(file: -1, rank: 0), .init(file: -1, rank: 0), .init(file: -1, rank: 0)]
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
        return [
            [.init(file: 1, rank: 1)],
            [.init(file: 1, rank: 1), .init(file: 1, rank: 1)],
            [.init(file: 1, rank: 1), .init(file: 1, rank: 1), .init(file: 1, rank: 1)],
            [.init(file: 1, rank: 1), .init(file: 1, rank: 1), .init(file: 1, rank: 1), .init(file: 1, rank: 1)],
            [.init(file: 1, rank: 1), .init(file: 1, rank: 1), .init(file: 1, rank: 1), .init(file: 1, rank: 1), .init(file: 1, rank: 1)],
            [.init(file: 1, rank: 1), .init(file: 1, rank: 1), .init(file: 1, rank: 1), .init(file: 1, rank: 1), .init(file: 1, rank: 1), .init(file: 1, rank: 1)],
            [.init(file: 1, rank: 1), .init(file: 1, rank: 1), .init(file: 1, rank: 1), .init(file: 1, rank: 1), .init(file: 1, rank: 1), .init(file: 1, rank: 1), .init(file: 1, rank: 1)],
            [.init(file: 1, rank: -1)],
            [.init(file: 1, rank: -1), .init(file: 1, rank: -1)],
            [.init(file: 1, rank: -1), .init(file: 1, rank: -1), .init(file: 1, rank: -1)],
            [.init(file: 1, rank: -1), .init(file: 1, rank: -1), .init(file: 1, rank: -1), .init(file: 1, rank: -1)],
            [.init(file: 1, rank: -1), .init(file: 1, rank: -1), .init(file: 1, rank: -1), .init(file: 1, rank: -1), .init(file: 1, rank: -1)],
            [.init(file: 1, rank: -1), .init(file: 1, rank: -1), .init(file: 1, rank: -1), .init(file: 1, rank: -1), .init(file: 1, rank: -1), .init(file: 1, rank: -1)],
            [.init(file: 1, rank: -1), .init(file: 1, rank: -1), .init(file: 1, rank: -1), .init(file: 1, rank: -1), .init(file: 1, rank: -1), .init(file: 1, rank: -1), .init(file: 1, rank: -1)],
            [.init(file: -1, rank: 1)],
            [.init(file: -1, rank: 1), .init(file: -1, rank: 1)],
            [.init(file: -1, rank: 1), .init(file: -1, rank: 1), .init(file: -1, rank: 1)],
            [.init(file: -1, rank: 1), .init(file: -1, rank: 1), .init(file: -1, rank: 1), .init(file: -1, rank: 1)],
            [.init(file: -1, rank: 1), .init(file: -1, rank: 1), .init(file: -1, rank: 1), .init(file: -1, rank: 1), .init(file: -1, rank: 1)],
            [.init(file: -1, rank: 1), .init(file: -1, rank: 1), .init(file: -1, rank: 1), .init(file: -1, rank: 1), .init(file: -1, rank: 1), .init(file: -1, rank: 1)],
            [.init(file: -1, rank: 1), .init(file: -1, rank: 1), .init(file: -1, rank: 1), .init(file: -1, rank: 1), .init(file: -1, rank: 1), .init(file: -1, rank: 1), .init(file: -1, rank: 1)],
            [.init(file: -1, rank: -1)],
            [.init(file: -1, rank: -1), .init(file: -1, rank: -1)],
            [.init(file: -1, rank: -1), .init(file: -1, rank: -1), .init(file: -1, rank: -1)],
            [.init(file: -1, rank: -1), .init(file: -1, rank: -1), .init(file: -1, rank: -1), .init(file: -1, rank: -1)],
            [.init(file: -1, rank: -1), .init(file: -1, rank: -1), .init(file: -1, rank: -1), .init(file: -1, rank: -1), .init(file: -1, rank: -1)],
            [.init(file: -1, rank: -1), .init(file: -1, rank: -1), .init(file: -1, rank: -1), .init(file: -1, rank: -1), .init(file: -1, rank: -1), .init(file: -1, rank: -1)],
            [.init(file: -1, rank: -1), .init(file: -1, rank: -1), .init(file: -1, rank: -1), .init(file: -1, rank: -1), .init(file: -1, rank: -1), .init(file: -1, rank: -1), .init(file: -1, rank: -1)],
            [.init(file: 0, rank: 1)],
            [.init(file: 0, rank: 1), .init(file: 0, rank: 1)],
            [.init(file: 0, rank: 1), .init(file: 0, rank: 1), .init(file: 0, rank: 1)],
            [.init(file: 0, rank: 1), .init(file: 0, rank: 1), .init(file: 0, rank: 1), .init(file: 0, rank: 1)],
            [.init(file: 0, rank: 1), .init(file: 0, rank: 1), .init(file: 0, rank: 1), .init(file: 0, rank: 1), .init(file: 0, rank: 1)],
            [.init(file: 0, rank: 1), .init(file: 0, rank: 1), .init(file: 0, rank: 1), .init(file: 0, rank: 1), .init(file: 0, rank: 1), .init(file: 0, rank: 1)],
            [.init(file: 1, rank: 0)],
            [.init(file: 1, rank: 0), .init(file: 1, rank: 0)],
            [.init(file: 1, rank: 0), .init(file: 1, rank: 0), .init(file: 1, rank: 0)],
            [.init(file: 1, rank: 0), .init(file: 1, rank: 0), .init(file: 1, rank: 0), .init(file: 1, rank: 0)],
            [.init(file: 1, rank: 0), .init(file: 1, rank: 0), .init(file: 1, rank: 0), .init(file: 1, rank: 0), .init(file: 1, rank: 0)],
            [.init(file: 1, rank: 0), .init(file: 1, rank: 0), .init(file: 1, rank: 0), .init(file: 1, rank: 0), .init(file: 1, rank: 0), .init(file: 1, rank: 0)],
            [.init(file: 0, rank: -1)],
            [.init(file: 0, rank: -1), .init(file: 0, rank: -1)],
            [.init(file: 0, rank: -1), .init(file: 0, rank: -1), .init(file: 0, rank: -1)],
            [.init(file: 0, rank: -1), .init(file: 0, rank: -1), .init(file: 0, rank: -1), .init(file: 0, rank: -1)],
            [.init(file: 0, rank: -1), .init(file: 0, rank: -1), .init(file: 0, rank: -1), .init(file: 0, rank: -1), .init(file: 0, rank: -1)],
            [.init(file: 0, rank: -1), .init(file: 0, rank: -1), .init(file: 0, rank: -1), .init(file: 0, rank: -1), .init(file: 0, rank: -1), .init(file: 0, rank: -1)],
            [.init(file: -1, rank: 0)],
            [.init(file: -1, rank: 0), .init(file: -1, rank: 0)],
            [.init(file: -1, rank: 0), .init(file: -1, rank: 0), .init(file: -1, rank: 0)],
            [.init(file: -1, rank: 0), .init(file: -1, rank: 0), .init(file: -1, rank: 0), .init(file: -1, rank: 0)],
            [.init(file: -1, rank: 0), .init(file: -1, rank: 0), .init(file: -1, rank: 0), .init(file: -1, rank: 0), .init(file: -1, rank: 0)],
            [.init(file: -1, rank: 0), .init(file: -1, rank: 0), .init(file: -1, rank: 0), .init(file: -1, rank: 0), .init(file: -1, rank: 0), .init(file: -1, rank: 0)]
        ]
    }
}
