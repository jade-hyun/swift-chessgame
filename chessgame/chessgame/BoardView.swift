//
//  BoardView.swift
//  chessgame
//
//  Created by jade.h on 2022/06/27.
//

import UIKit

final class BoardView: UIView {
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
                let label = UILabel()
                label.tag = (rank << 4) | file
                label.textAlignment = .center
                label.layer.borderWidth = 1 / UIScreen.main.scale
                label.layer.borderColor = UIColor.black.cgColor

                fileStackView.addArrangedSubview(label)
            }
        }
    }

    private func updateBoard() {
        for rank in 1...8 {
            for file in 1...8 {
                guard let label = self.viewWithTag((rank << 4) | file) as? UILabel else {
                    continue
                }

                if let piece = pieces[Position(file: file, rank: rank)] {
                    label.text = String(piece.symbol)
                } else {
                    label.text = nil
                }
            }
        }
    }
}
