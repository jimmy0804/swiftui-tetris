//
//  GameStartView.swift
//  swiftui-tertis
//
//  Created by Jimmy Yeung on 27/11/2019.
//  Copyright © 2019 Jimmy Yeung. All rights reserved.
//

import SwiftUI

struct GameStartView: View {
    @EnvironmentObject var gameManager: GameManager
    
    var body: some View {
        Button(action: {
            self.gameManager.startGame()
        }) {
            Text("Start")
        }
    }
}

struct GameStartView_Previews: PreviewProvider {
    static var previews: some View {
        GameStartView()
    }
}
