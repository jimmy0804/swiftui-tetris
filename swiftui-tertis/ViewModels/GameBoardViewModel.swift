//
//  GameBoardViewModel.swift
//  swiftui-tertis
//
//  Created by Jimmy Yeung on 27/11/2019.
//  Copyright © 2019 Jimmy Yeung. All rights reserved.
//

import UIKit

class GameBoardViewModel: ObservableObject {
    
    enum GameBoardStyle {
        case standard
        case tall
        case custom(rows: Int, columns: Int)
        
        var gridSize: (rows: Int, columns: Int) {
            switch self {
            case .standard:
                return (rows: 20, columns: 10)
            case .tall:
                return (rows: 24, columns: 10)
            case .custom(let rows, let columns):
                return (rows: rows, columns: columns)
            }
        }
    }
        
    // MARK: - Properties

    @Published var gameboard = [[Tile]]()
    private let gameboardStyle: GameBoardStyle
    
    // MARK: - Init

    init(gameboardStyle: GameBoardStyle) {
        self.gameboardStyle = gameboardStyle
        newGameboard()
    }
    
    func newGameboard() {
        createGameboard(with: gameboardStyle)
    }
    
    // MARK: -
    
    private func createGameboard(with style: GameBoardStyle) {
        let row = Array.init(repeating: Tile(), count: style.gridSize.columns)
        gameboard = Array.init(repeating: row, count: style.gridSize.rows)
    }
    
//    private func updateGameboard() {
//        let newGameboard = [[Tile]]()
//
//        for row in 0..<gameboardStyle.size.height {
//            let startIndex = row * gameboardStyle.size.height
//            let endIndex = startIndex + gameboardStyle.size.height
//            let currentRow = gameboardBackupStore[startIndex..<endIndex]
//            gameboard.append(Array(currentRow))
//        }
//
//        gameboard = newGameboard
//    }
}
