//
//  Tile.swift
//  swiftui-tertis
//
//  Created by Jimmy Yeung on 1/12/2019.
//  Copyright © 2019 Jimmy Yeung. All rights reserved.
//

import UIKit

struct Tile: Identifiable {

    // MARK: - Property

    let id: UUID
    let coordinate: CGPoint

    var color: UIColor = .clear
    
    // MARK: - Init

    init(coordinate: CGPoint) {
        id = UUID()
        self.coordinate = coordinate
    }
    
    // MARK: - Methods
    
    mutating func render(block: Block) {
        self.color = block.color
    }
    
    mutating func reset() {
        self.color = .clear
    }
}

extension Tile: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
