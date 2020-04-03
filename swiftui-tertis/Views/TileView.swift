//
//  TileView.swift
//  swiftui-tertis
//
//  Created by Yeung, Jimmy(AWF) on 27/11/2019.
//  Copyright © 2019 Jimmy Yeung. All rights reserved.
//

import UIKit
import SwiftUI

struct TileView: View {
    var tile: Tile

    var body: some View {
        Rectangle()
            .fill(Color(self.tile.color))
            .border(Color.secondary, width: 0.5)
    }
}

struct TileView_Previews: PreviewProvider {
    static var previews: some View {
        return TileView(tile: Tile(coordinate: .zero))
    }
}
