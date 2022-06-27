//
//  Board.swift
//  chessgame
//
//  Created by jade.h on 2022/06/20.
//

import Foundation

enum BoardError: Error {
    case 해당위치에말존재
    case 이미최대로추가
}

class Board {
    private let size = 8
    private var pieces: [Position: Piece] = [:]

    var isPieceExists: Bool {
        return !pieces.isEmpty
    }

    private func score(for color: PieceColor) -> Int {

        return pieces.filter({ $0.value.color == color }).reduce(0, { $0 + type(of: $1.value).score })
    }

    func add(piece: Piece, to position: Position) throws {
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

    func display() -> String {
        var displayText = ""
        for y in 0..<size {
            for x in 0..<size {
                displayText += String(pieces[.init(file: x, rank: y)]?.symbol ?? ".")
            }

            if y < size - 1 {
                displayText += "\n"
            }
        }

        return displayText
    }
}
