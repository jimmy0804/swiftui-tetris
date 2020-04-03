//
//  Shape.swift
//  swiftui-tertis
//
//  Created by Jimmy Yeung on 27/11/2019.
//  Copyright © 2019 Jimmy Yeung. All rights reserved.
//

import UIKit

enum ShapeRotationDirection: CaseIterable {
    case top
    case right
    case bottom
    case left
    
    static func getRandomDirection() -> Self {
        return self.allCases.randomElement() ?? .top
    }
    
    mutating func rotateToNextDirection(isClockwise: Bool) {
        switch self {
        case .top:
            self = isClockwise ? .right : .left
        case .right:
            self = isClockwise ? .bottom : .top
        case .bottom:
            self = isClockwise ? .left : .right
        case .left:
            self = isClockwise ? .top : .bottom
        }
    }
}

enum Shape: CaseIterable {
    case s // S-shape
    case z // Z-shape
    case t // T-shape
    case l // L-shape
    case line // Line-shape
    case mirroredL // MirroredL-shape
    case square

    var color: UIColor {
        switch self {
        case .s:
            return .blue
        case .z:
            return .red
        case .t:
            return .cyan
        case .l:
            return .brown
        case .line:
            return .green
        case .mirroredL:
            return .orange
        case .square:
            return .purple
        }
    }
    
    var basePointsForAllRotationDirection: [ShapeRotationDirection: [CGPoint]] {
        switch self {
        case .s:
            let vertical = [CGPoint(x: 1, y: 0), CGPoint(x: 1, y: 1), CGPoint(x: 0, y: 1), CGPoint(x: 0, y: 2)]
            let horizontial = [CGPoint(x: 0, y: 0), CGPoint(x: 0, y: 1), CGPoint(x: 1, y: 1), CGPoint(x: 1, y: 2)]
            return [
                .top: vertical,
                .right: horizontial,
                .bottom: vertical,
                .left: horizontial
            ]
        case .z:
            let vertical = [CGPoint(x: 0, y: 0), CGPoint(x: 0, y: 1), CGPoint(x: 1, y: 1), CGPoint(x: 1, y: 2)]
            let horizontial = [CGPoint(x: 0, y: 1), CGPoint(x: 1, y: 1), CGPoint(x: 1, y: 0), CGPoint(x: 2, y: 0)]
            return [
                .top: vertical,
                .right: horizontial,
                .bottom: vertical,
                .left: horizontial,
            ]
        case .t:
            return [
                .top: [CGPoint(x: 1, y: 0), CGPoint(x: 0, y: 1), CGPoint(x: 1, y: 1), CGPoint(x: 2, y: 1)],
                .right: [CGPoint(x: 0, y: 0), CGPoint(x: 0, y: 1), CGPoint(x: 0, y: 2), CGPoint(x: 1, y: 1)],
                .bottom: [CGPoint(x: 0, y: 0), CGPoint(x: 1, y: 0), CGPoint(x: 2, y: 0), CGPoint(x: 1, y: 1)],
                .left: [CGPoint(x: 1, y: 0), CGPoint(x: 1, y: 1), CGPoint(x: 1, y: 2), CGPoint(x: 0, y: 1)],
            ]
        case .l:
            return [
                .top: [CGPoint(x: 0, y: 0), CGPoint(x: 0, y: 1), CGPoint(x: 0, y: 2), CGPoint(x: 1, y: 2)],
                .right: [CGPoint(x: 0, y: 0), CGPoint(x: 0, y: 1), CGPoint(x: 1, y: 0), CGPoint(x: 2, y: 0)],
                .bottom: [CGPoint(x: 0, y: 0), CGPoint(x: 1, y: 0), CGPoint(x: 1, y: 1), CGPoint(x: 1, y: 2)],
                .left: [CGPoint(x: 0, y: 1), CGPoint(x: 1, y: 1), CGPoint(x: 2, y: 0), CGPoint(x: 2, y: 1)],
            ]
        case .line:
            let vertical = [CGPoint(x: 0, y: 0), CGPoint(x: 1, y: 0), CGPoint(x: 2, y: 0), CGPoint(x: 3, y: 0)]
            let horizontial = [CGPoint(x: 0, y: 0), CGPoint(x: 0, y: 1), CGPoint(x: 0, y: 2), CGPoint(x: 0, y: 3)]
            return [
                .top: vertical,
                .right: horizontial,
                .bottom: vertical,
                .left: horizontial
            ]
        case .mirroredL:
            return [
                .top: [CGPoint(x: 1, y: 0), CGPoint(x: 1, y: 1), CGPoint(x: 1, y: 2), CGPoint(x: 0, y: 2)],
                .right: [CGPoint(x: 0, y: 0), CGPoint(x: 0, y: 1), CGPoint(x: 1, y: 1), CGPoint(x: 2, y: 1)],
                .bottom: [CGPoint(x: 0, y: 0), CGPoint(x: 1, y: 0), CGPoint(x: 0, y: 1), CGPoint(x: 0, y: 2)],
                .left: [CGPoint(x: 0, y: 0), CGPoint(x: 1, y: 0), CGPoint(x: 2, y: 0), CGPoint(x: 2, y: 1)],
            ]
        case .square:
            let points = [CGPoint(x: 0, y: 0), CGPoint(x: 0, y: 1), CGPoint(x: 1, y: 0), CGPoint(x: 1, y: 1)]
            return [
                .top: points,
                .right: points,
                .bottom: points,
                .left: points
            ]
        }
    }
    
    static func getRandomShape() -> Shape {
        Self.allCases.randomElement()!
    }
}
