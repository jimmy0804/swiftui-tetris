//
//  GameBoardView.swift
//  swiftui-tertis
//
//  Created by Yeung, Jimmy(AWF) on 27/11/2019.
//  Copyright © 2019 Jimmy Yeung. All rights reserved.
//

import SwiftUI

struct GameBoardView: View {
    let gameBoardViewModel: GameBoardViewModel
    
    var body: some View {
        GeometryReader { proxy in
            self.gridView(size: proxy.size)
                .border(Color.black, width: 1)
        }
        .onAppear() {
//            self.gameBoardViewModel.newGameboard()
        }
    }
    
    func gridView(size: CGSize) -> some View {
        let tileWidth = size.width / CGFloat(self.gameBoardViewModel.gameboard.count)
        let tileHeight = tileWidth
        let tileSize = CGSize(width: tileWidth, height: tileHeight)
        
        return VStack(alignment: .center, spacing: 0) {
            ForEach(self.gameBoardViewModel.gameboard, id: \.self) { columns in
                self.gridRow(WithColumns: columns, andTileSize: tileSize)
            }
        }
    }
    
    func gridRow(WithColumns columns: [Tile], andTileSize size: CGSize) -> some View {
        HStack(alignment: .center, spacing: 0) {
            ForEach(columns) { tile in
                TileView(tile: tile)
            }
        }
    }
}

struct GameBoardView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = GameBoardViewModel(gameboardStyle: .standard)
        return GameBoardView(gameBoardViewModel: viewModel)
    }
}
