//
//  ContentView.swift
//  Mastermind
//
//  Created by Virzi, Valeria (SE-5/7AFI2) on 18.04.23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = MastermindViewModel()
    @State private var isGameWonViewPresented = false
    @State private var isGameLostViewPresented = false

    var body: some View {
        ZStack {
            GameView(viewModel: viewModel) // das Spiel wird dargestellt
                .blur(radius: isGameWonViewPresented || isGameLostViewPresented ? 20 : 0)

            if isGameWonViewPresented {
                GameWonView(viewModel: viewModel, closeAction: {
                    isGameWonViewPresented = false
                }, wonGame: $viewModel.wonGame)
                    .transition(.move(edge: .bottom))
                    .animation(.easeInOut(duration: 0.3))
            }

            if isGameLostViewPresented {
                GameLostView(viewModel: viewModel, closeAction: {
                    isGameLostViewPresented = false
                }, lostGame: $viewModel.lostGame)
                    .transition(.move(edge: .bottom))
                    .animation(.easeInOut(duration: 0.3))
            }

        }
        .onReceive(viewModel.$wonGame) { wonGame in
            if wonGame {
                isGameWonViewPresented = true
            }
        }
        .onReceive(viewModel.$lostGame) { lostGame in
            if lostGame {
                isGameLostViewPresented = true
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
