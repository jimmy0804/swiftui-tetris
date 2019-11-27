//
//  Tile.swift
//  swiftui-tertis
//
//  Created by Jimmy Yeung on 27/11/2019.
//  Copyright © 2019 Jimmy Yeung. All rights reserved.
//

import UIKit

struct Tile: Hashable, Identifiable {

    var id: UUID
    var color: UIColor
    
    init(color: UIColor = .clear) {
        id = UUID()
        self.color = color
    }
}
