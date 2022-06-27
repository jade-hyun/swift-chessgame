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
}
