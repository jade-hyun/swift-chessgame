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
    var score: Int { get }
    var color: PieceColor { get }
    var symbol: Character { get }
}

struct Position: Hashable {
    let x: Int
    let y: Int
}

struct Pawn: Piece {
    let score = 1
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
    let score = 3
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
    let score = 3
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

struct Luke: Piece {
    let score = 5
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
    let score = 9
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
