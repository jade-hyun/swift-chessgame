//
//  ViewController.swift
//  chessgame
//
//  Created by jade.h on 2022/06/20.
//

import UIKit

class ViewController: UIViewController {

    let boardView = BoardView()
    let board = Board()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(boardView)

        boardView.translatesAutoresizingMaskIntoConstraints = false
        boardView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        boardView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        boardView.heightAnchor.constraint(equalTo: boardView.widthAnchor).isActive = true

        boardView.delegate = self

        do {
            try board.initializePieces()
        } catch {
            print("보드를 초기화 할 수 없음", error)
        }

        boardView.pieces = board.pieces
    }


}

extension ViewController: BoardViewDelegate {
    func pieceDidSelect(_ boardView: BoardView, position: Position) {
        boardView.clearEmphasize()

        if let piece = board.pieces[position] {
            let candidates = piece.availables(for: position, boardSize: type(of: board).size)

            let availables = candidates.filter { path, _ in
                board.canMove(from: position, path: path)
            }.map(\.finalPosition)

            boardView.emphasize(positions: [position], color: .blue)
            boardView.emphasize(positions: availables)
        }
    }
}

