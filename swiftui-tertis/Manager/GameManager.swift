//
//  GameManager.swift
//  swiftui-tertis
//
//  Created by Jimmy Yeung on 27/11/2019.
//  Copyright © 2019 Jimmy Yeung. All rights reserved.
//

import Foundation

enum GameState {
    case notStarted
    case started
    case gameover
}

class GameManager: ObservableObject {
    @Published var gameState: GameState = .notStarted
    
    func startGame() {
        gameState = .started
    }
}
