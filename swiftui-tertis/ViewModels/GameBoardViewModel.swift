//
//  GameBoardViewModel.swift
//  swiftui-tertis
//
//  Created by Jimmy Yeung on 27/11/2019.
//  Copyright © 2019 Jimmy Yeung. All rights reserved.
//

import UIKit

typealias GameBoard = [[Tile]]
typealias GameBoardSize = (rows: Int, columns: Int)

enum GameBoardConfig {
    case standard
    case tall
    
    var gridSize: GameBoardSize {
        switch self {
        case .standard:
            return (rows: 20, columns: 10)
        case .tall:
            return (rows: 24, columns: 10)
        }
    }

    var birthAnchorPoint: CGPoint {
        CGPoint(x: gridSize.columns / 2, y: 0)
    }
}

final class GameBoardViewModel: ObservableObject {
        
    // MARK: - Properties

    @Published var gameBoard: GameBoard = [[Tile]]()

    private let config: GameBoardConfig
    private var gameBlockFactory: GameBlockFactory
    private var collisionDetector: CollisionDetectable
    private var timer: GameTimer?

    private var renderedBlockTiles = [Tile]()
    private var occupiedTiles = [Tile]() {
        didSet {
            
            collisionDetector.updateOccupiedTiles(occupiedTiles)
        }
    }
    private var currentBlock: Block?
    
    // MARK: - Init

    init(config: GameBoardConfig,
         gameBlockFactory: GameBlockFactory,
         collisionDetector: CollisionDetectable) {
        self.config = config
        self.gameBlockFactory = gameBlockFactory
        self.collisionDetector = collisionDetector
        self.timer = GameTimer(delegate: self)
    }
    
    func startGame() {
        makeTiles()
        timer?.start()
    }
    
    private func makeTiles() {
        gameBoard = (0..<config.gridSize.rows).map { i in
            (0..<config.gridSize.columns).map{ j in Tile(coordinate: CGPoint(x: j, y: i) )}
        }
    }
    
    private func makeNewBlockIfNeeded() {
        guard currentBlock == nil else { return }
        
        currentBlock = gameBlockFactory.makeBlockWithRandomShape()
    }

    public func moveBlockTo(_ direction: BlockDirection) {
        guard let block = currentBlock else { return }

        let targetAnchorPoint = block.getTargetAnchorIfMove(direction)
        let collisionStatus = collisionDetector.canMove(block: block, to: targetAnchorPoint)
        
        switch collisionStatus {
        case .noCollision:
            currentBlock?.applyNewAnchorPoint(targetAnchorPoint)
        case .collided(with: let bounds):
            let isCollidedWithTop = bounds.filter{$0 == .top}.isEmpty == false
            let isCollidedWithBottom = bounds.filter{$0 == .bottom}.isEmpty == false
            
            if isCollidedWithTop {
                // Game over
            } else if isCollidedWithBottom {
                occupiedTiles.append(contentsOf: getTiles(with: block.renderCoordinates))
                currentBlock = nil
            } else {
                // left, right
            }
        }
        
        render()
    }
    
    public func rotateBlock(_ isClockwise: Bool = true) {
        guard let block = currentBlock else { return }
        
        let collisionStatus = collisionDetector.canRotate(block: block)
        
        switch collisionStatus {
        case .noCollision:
            currentBlock?.rotate()
        case .collided(with: let bounds):
            let isCollidedWithTop = bounds.filter{$0 == .top}.isEmpty == false
            let isCollidedWithBottom = bounds.filter{$0 == .bottom}.isEmpty == false
            
            if isCollidedWithTop {
                // Game over
            } else if isCollidedWithBottom {
                occupiedTiles.append(contentsOf: getTiles(with: block.renderCoordinates))
                currentBlock = nil
            } else {
                // left, right
            }
        }
        
        render()
    }
}

// MARK: - Render

private extension GameBoardViewModel {
    private func render() {
        cleanUpRenderedBlockTiles()
        renderCurrentBlockOnGameBoard()
        renderOccupiedTiles()
    }
    
    private func cleanUpRenderedBlockTiles() {
        renderedBlockTiles.forEach { tile in
            let x = Int(tile.coordinate.x)
            let y = Int(tile.coordinate.y)
            if x >= 0 && y >= 0 {
                gameBoard[y][x].reset()
            }
        }
        renderedBlockTiles.removeAll(keepingCapacity: true)
    }
    
    private func renderCurrentBlockOnGameBoard() {
        guard let block = currentBlock else { return }

        for coordinates in block.renderCoordinates {
            let x = Int(coordinates.x)
            let y = Int(coordinates.y)
            if x >= 0 && y >= 0 {
                gameBoard[y][x].render(block: block)
                renderedBlockTiles.append(gameBoard[y][x])
            }
        }
    }
    
    private func renderOccupiedTiles() {
        for tile in occupiedTiles {
            let x = Int(tile.coordinate.x)
            let y = Int(tile.coordinate.y)
            gameBoard[y][x] = tile
        }
    }
}

// MARK: - GameTimerDelegate

extension GameBoardViewModel: GameTimerDelegate {
    func timerFired() {
        makeNewBlockIfNeeded()
        moveBlockTo(.down)
    }
}

extension GameBoardViewModel {
    /// TODO: Check out of bound
    private func getTiles(with points: [CGPoint]) -> [Tile] {
        return points.compactMap { point -> Tile? in
            let x = Int(point.x)
            let y = Int(point.y)
            
            if x >= 0 && y >= 0 {
                return gameBoard[y][x]
            }
            return nil
        }
    }
}
