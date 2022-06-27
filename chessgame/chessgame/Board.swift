//
//  Board.swift
//  chessgame
//
//  Created by jade.h on 2022/06/20.
//

import Foundation

enum BoardError: Error {
    case 유효하지않은위치에추가
    case 해당위치에말존재
    case 이미최대로추가
}

class Board {
    static let size = 8
    private var pieces: [Position: Piece] = [:]

    var isPieceExists: Bool {
        return !pieces.isEmpty
    }

    func initializePieces() throws {
        pieces = [:]

        let blackPawn = Pawn(color: .black)
        let blackKnight = Knight(color: .black)
        let blackBishop = Bishop(color: .black)
        let blackRook = Rook(color: .black)
        let blackQueen = Queen(color: .black)

        for file in 1...Self.size {
            try add(piece: blackPawn, to: .init(file: file, rank: 2))
        }

        try add(piece: blackKnight, to: .init(file: 2, rank: 1))
        try add(piece: blackKnight, to: .init(file: 7, rank: 1))
        try add(piece: blackBishop, to: .init(file: 3, rank: 1))
        try add(piece: blackBishop, to: .init(file: 6, rank: 1))
        try add(piece: blackRook, to: .init(file: 1, rank: 1))
        try add(piece: blackRook, to: .init(file: 8, rank: 1))
        try add(piece: blackQueen, to: .init(file: 5, rank: 1))

        let whitePawn = Pawn(color: .white)
        let whiteKnight = Knight(color: .white)
        let whiteBishop = Bishop(color: .white)
        let whiteRook = Rook(color: .white)
        let whiteQueen = Queen(color: .white)

        for file in 1...Self.size {
            try add(piece: whitePawn, to: .init(file: file, rank: 7))
        }

        try add(piece: whiteKnight, to: .init(file: 2, rank: 8))
        try add(piece: whiteKnight, to: .init(file: 7, rank: 8))
        try add(piece: whiteBishop, to: .init(file: 3, rank: 8))
        try add(piece: whiteBishop, to: .init(file: 6, rank: 8))
        try add(piece: whiteRook, to: .init(file: 1, rank: 8))
        try add(piece: whiteRook, to: .init(file: 8, rank: 8))
        try add(piece: whiteQueen, to: .init(file: 5, rank: 8))
    }

    func add(piece: Piece, to position: Position) throws {
        guard position.isInBoard(Self.size) else {
            throw BoardError.유효하지않은위치에추가
        }

        guard pieces[position] == nil else {
            throw BoardError.해당위치에말존재
        }

        guard pieces.filter({ type(of: $0.value) == type(of: piece) && $0.value.color == piece.color }).count < type(of: piece).maxCount else {
            throw BoardError.이미최대로추가
        }

        pieces[position] = piece
    }

    func allScore() -> String {
        let scoreText = PieceColor.allCases.map {
            let score = score(for: $0)
            return "\($0): \(score)"
        }.joined(separator: "\n")

        return scoreText
    }

    private func score(for color: PieceColor) -> Int {

        return pieces.filter({ $0.value.color == color }).reduce(0, { $0 + type(of: $1.value).score })
    }

    func display() -> String {
        var displayText = ""
        for rank in 1...Self.size {
            for file in 1...Self.size {
                displayText += String(pieces[.init(file: file, rank: rank)]?.symbol ?? ".")
            }

            if rank < Self.size {
                displayText += "\n"
            }
        }

        return displayText
    }
}
