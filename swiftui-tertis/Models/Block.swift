//
//  Block.swift
//  swiftui-tertis
//
//  Created by Jimmy Yeung on 1/12/2019.
//  Copyright © 2019 Jimmy Yeung. All rights reserved.
//

import UIKit

enum BlockDirection {
    case left
    case right
    case down
    case up
}

 struct Block {
    private(set) var anchorX: CGFloat
    private(set) var anchorY: CGFloat
    
    private(set) var rotationDirection: ShapeRotationDirection
    
    /// The points that define the shape of a block in a two-dimensional coordinate system
    var baseCoordinates: [CGPoint] {
        return shape.basePointsForAllRotationDirection[rotationDirection] ?? []
    }
    
    /// The points that define the actual block location on a gameboard
    /// This value will get updated when either `anchorX` or `anchorY` changes its value.
    var renderCoordinates: [CGPoint] {
        return baseCoordinates.map {
            CGPoint(x: $0.x + anchorX, y: $0.y + anchorY)
        }
    }
    
    var color: UIColor {
        return shape.color
    }
    
    private var shape: Shape
    
    init(shape: Shape,
         birthAnchorPoint: CGPoint) {
        self.shape = shape
        self.rotationDirection = .getRandomDirection()
        self.anchorX = birthAnchorPoint.x
        self.anchorY = birthAnchorPoint.y - 1
    }
    
    func getTargetAnchorIfMove(_ direction: BlockDirection) -> CGPoint {
        var newAnchorX = anchorX
        var newAnchorY = anchorY

        switch direction {
        case .left:
            newAnchorX -= 1
        case .right:
            newAnchorX += 1
        case .down:
            newAnchorY += 1
        case .up:
            newAnchorY -= 1
        }
        
        return CGPoint(x: newAnchorX, y: newAnchorY)
    }
    
    mutating func applyNewAnchorPoint(_ point: CGPoint) {
        self.anchorX = point.x
        self.anchorY = point.y
    }
    
    mutating func rotate(clockwise: Bool = true) {
        self.rotationDirection.rotateToNextDirection(isClockwise: clockwise)
    }
}
