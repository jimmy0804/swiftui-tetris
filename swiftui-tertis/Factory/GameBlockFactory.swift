//
//  GameBlockFactory.swift
//  swiftui-tertis
//
//  Created by Jimmy Yeung on 28/11/2019.
//  Copyright © 2019 Jimmy Yeung. All rights reserved.
//

import UIKit

struct GameBlockFactory {

    private let gameBoardConfig: GameBoardConfig
    
    init(gameBoardConfig: GameBoardConfig) {
        self.gameBoardConfig = gameBoardConfig
    }

    mutating func makeBlockWithRandomShape() -> Block {
        let randomShape = Shape.getRandomShape()
        return Block(shape: randomShape, birthAnchorPoint: gameBoardConfig.birthAnchorPoint)
    }
}
