//
//  BoardView.swift
//  chessgame
//
//  Created by jade.h on 2022/06/27.
//

import UIKit

protocol BoardViewDelegate: AnyObject {
    func pieceDidSelect(_ boardView: BoardView, position: Position)
}

final class BoardView: UIView {
    weak var delegate: BoardViewDelegate?

    private let rankStackView = UIStackView()

    var pieces: [Position: Piece] = [:] {
        didSet {
            updateBoard()
        }
    }

    init() {
        super.init(frame: .zero)

        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        addSubview(rankStackView)

        rankStackView.translatesAutoresizingMaskIntoConstraints = false
        rankStackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        rankStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        rankStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        rankStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        rankStackView.axis = .vertical
        rankStackView.distribution = .fillEqually
        
        for rank in 1...8 {
            let fileStackView = UIStackView()
            fileStackView.axis = .horizontal
            fileStackView.distribution = .fillEqually

            rankStackView.addArrangedSubview(fileStackView)

            for file in 1...8 {
                let button = UIButton()
                button.tag = (rank << 4) | file
                button.layer.borderWidth = 1 / UIScreen.main.scale
                button.layer.borderColor = UIColor.black.cgColor
                button.setTitleColor(.black, for: .normal)
                button.addTarget(self, action: #selector(selected(_:)), for: .touchUpInside)

                fileStackView.addArrangedSubview(button)
            }
        }
    }

    @objc
    private func selected(_ button: UIButton) {
        guard button.tag > 0 else {
            return
        }

        let file = button.tag & 0xf
        let rank = button.tag >> 4

        delegate?.pieceDidSelect(self, position: Position(file: file, rank: rank))
    }

    private func updateBoard() {
        for rank in 1...8 {
            for file in 1...8 {
                guard let button = button(forRank: rank, file: file) else {
                    continue
                }

                if let piece = pieces[Position(file: file, rank: rank)] {
                    button.setTitle(String(piece.symbol), for: .normal)
                } else {
                    button.setTitle(nil, for: .normal)
                }
            }
        }
    }

    private func button(forRank: Int, file: Int) -> UIButton? {
        return viewWithTag((forRank << 4) | file) as? UIButton
    }

    private func button(for position: Position) -> UIButton? {
        return button(forRank: position.rank, file: position.file)
    }

    func emphasize(positions: [Position], color: UIColor = .red) {
        positions.forEach { position in
            guard let button = button(for: position) else {
                return
            }

            button.layer.borderColor = color.cgColor
            button.layer.borderWidth = 2
        }
    }

    func clearEmphasize() {
        for rank in 1...8 {
            for file in 1...8 {
                guard let button = button(forRank: rank, file: file) else {
                    continue
                }

                button.layer.borderColor = UIColor.black.cgColor
                button.layer.borderWidth = 1 / UIScreen.main.scale
            }
        }
    }
}
