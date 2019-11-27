//
//  MainContentView.swift
//  swiftui-tertis
//
//  Created by Jimmy Yeung on 27/11/2019.
//  Copyright © 2019 Jimmy Yeung. All rights reserved.
//

import SwiftUI

struct MainContentView: View {
    @EnvironmentObject var gameManager: GameManager

    var body: some View {
        containedView()
    }
    
    func containedView() -> AnyView {
        switch gameManager.gameState {
        case .notStarted:
            return AnyView(GameStartView())
        case .started:
            let viewModel = GameBoardViewModel(gameboardStyle: .standard)
            let gameBoardView = GameBoardView(gameBoardViewModel: viewModel)
                .padding(20)
            return AnyView(gameBoardView)
        case .gameover:
            return AnyView(GameStartView())
        }
    }
}

struct MainContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainContentView()
    }
}
