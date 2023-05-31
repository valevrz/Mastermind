//
//  GameView.swift
//  Mastermind
//
//  Created by Virzi, Valeria (SE-5/7AFI2) on 10.05.23.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var viewModel: MastermindViewModel
    
    var body: some View {
        VStack {
            VStack {
                Spacer()
                ColorCodeView(colorCode: viewModel.colorCode, isGameOver: viewModel.isGameOver)
                Spacer()
                GameboardView(viewModel: viewModel)
            }
            .padding()
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(viewModel: MastermindViewModel())
    }
}
