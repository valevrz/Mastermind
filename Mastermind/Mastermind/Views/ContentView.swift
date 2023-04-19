//
//  ContentView.swift
//  Mastermind
//
//  Created by Virzi, Valeria (SE-5/7AFI2) on 18.04.23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = MastermindViewModel()

    var body: some View {
        VStack {
            Spacer()
            ColorCodeView(colorCode: viewModel.colorCode)
            Spacer()
            GameboardView(viewModel: viewModel)
            Button("New Game") {
                viewModel.newGame()
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
