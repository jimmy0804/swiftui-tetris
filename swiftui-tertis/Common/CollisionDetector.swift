//
//  CollisionDetector.swift
//  swiftui-tertis
//
//  Created by Jimmy Yeung on 1/12/2019.
//  Copyright © 2019 Jimmy Yeung. All rights reserved.
//

import UIKit

enum CollisionStatus {
    case noCollision
    case collided(with: [CollisionBound])
}

enum CollisionBound {
    case top
    case bottom
    case left
    case right
}

protocol CollisionDetectable {
    func updateOccupiedTiles(_ tiles: [Tile])
    func canMove(block: Block, to anchorPoint: CGPoint) -> CollisionStatus
    func canRotate(block: Block) -> CollisionStatus
}

final class CollisionDetector: CollisionDetectable {
    
    // MARK: - Property

    private var gameBoardConfig: GameBoardConfig
    private var occupiedTiles = [Tile]()
    
    private var numberOfRows: Int {
        return gameBoardConfig.gridSize.rows
    }
    private var numberOfColumns: Int {
        return gameBoardConfig.gridSize.columns
    }
    
    private var bottomOccupiedPoints: [CGFloat: CGFloat] {
        var bottomOccupiedPoints = [CGFloat: CGFloat]()

        for occupiedTile in occupiedTiles {
            let points = occupiedTile.coordinate

            if let perviousY = bottomOccupiedPoints[points.x] {
                bottomOccupiedPoints[points.x] = min(perviousY, points.y)
            } else {
                bottomOccupiedPoints[points.x] = points.y
            }
        }
        
        return bottomOccupiedPoints
    }
    
    // MARK: - Init

    init(gameBoardConfig: GameBoardConfig) {
        self.gameBoardConfig = gameBoardConfig
    }

    // MARK: - Methods
    
    func updateOccupiedTiles(_ tiles: [Tile]) {
        self.occupiedTiles = tiles
    }
    
    func canMove(block: Block, to anchorPoint: CGPoint) -> CollisionStatus {
        return checkCollisionStatus(for: block, in: anchorPoint)
    }
    
    func canRotate(block: Block) -> CollisionStatus {
        let anchorPoint = CGPoint(x: block.anchorX, y: block.anchorY)
        return checkCollisionStatus(for: block, in: anchorPoint, isRotate: true)
    }
    
    private func checkCollisionStatus(for block: Block,
                                      in anchorPoint: CGPoint,
                                      isRotate: Bool = false) -> CollisionStatus {

        var checkingBlock = block
        if isRotate {
            checkingBlock.rotate()
        }
        checkingBlock.applyNewAnchorPoint(anchorPoint)
        let targetRenderCoordinates = checkingBlock.renderCoordinates
        
        var colliedBounds = [CollisionBound]()
        
        for targetRenderCoordinate in targetRenderCoordinates {
            
            let didTouchTopBound = targetRenderCoordinate.y < 0
            if didTouchTopBound {
                colliedBounds.append(.top)
            }
            
            let didTouchLeftBound = targetRenderCoordinate.x < 0
            if didTouchLeftBound {
                colliedBounds.append(.left)
            }
            
            let didTouchRightBound = targetRenderCoordinate.x >= CGFloat(numberOfColumns)
            if didTouchRightBound {
                colliedBounds.append(.right)
            }
            
            let didTouchBottomBound = bottomOccupiedPoints
                .contains{ $0 == targetRenderCoordinate.x && targetRenderCoordinate.y >= $1 } ||
                targetRenderCoordinate.y >= CGFloat(numberOfRows)
            if didTouchBottomBound {
                colliedBounds.append(.bottom)
            }
        }
        
        return colliedBounds.isEmpty ? .noCollision : .collided(with: colliedBounds)
    }
}
