//
//  GameBoardView.swift
//  swiftui-tertis
//
//  Created by Jimmy Yeung on 27/11/2019.
//  Copyright © 2019 Jimmy Yeung. All rights reserved.
//

import SwiftUI

struct GameBoardView: View {
    
    @ObservedObject var gameboardViewModel: GameBoardViewModel
    @State private var dragPosition: CGSize = .zero
    
    var body: some View {
        GeometryReader { proxy in
            self.gridView(size: proxy.size)
                .border(Color.secondary, width: 1)
        }.onAppear {
            self.gameboardViewModel.startGame()
        }.gesture(
            DragGesture(minimumDistance: 2)
                .onChanged { value in
                    self.dragPosition = CGSize(width: value.translation.width, height: value.translation.height)
                }
                .onEnded { value in
                    let isDraggedLeft = value.translation.width < self.dragPosition.width
                    let isDraggedRight = value.translation.width > self.dragPosition.width
                    self.dragPosition = .zero
                    
                    if isDraggedLeft {
                        self.gameboardViewModel.moveBlockTo(.left)
                    } else if isDraggedRight {
                        self.gameboardViewModel.moveBlockTo(.right)
                    }
                }
        ).onTapGesture {
            self.gameboardViewModel.rotateBlock()
        }
    }
    
    func gridView(size: CGSize) -> some View {
        let tileWidth = size.width / CGFloat(self.gameboardViewModel.gameBoard.count)
        let tileHeight = tileWidth
        let tileSize = CGSize(width: tileWidth, height: tileHeight)
        
        return VStack(alignment: .center, spacing: 0) {
            ForEach(self.gameboardViewModel.gameBoard, id: \.self) { columns in
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
        let config = GameBoardConfig.standard
        let collisionDetector = CollisionDetector(gameBoardConfig: config)
        let gameboardViewModel = GameBoardViewModel(config: config, gameBlockFactory: GameBlockFactory(gameBoardConfig: config), collisionDetector: collisionDetector)
        return GameBoardView(gameboardViewModel: gameboardViewModel)
    }
}
