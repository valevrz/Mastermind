//
//  GameWonView.swift
//  Mastermind
//
//  Created by Virzi, Valeria (SE-5/7AFI2) on 03.05.23.
//

import SwiftUI

struct GameWonView: View {
    @ObservedObject var viewModel: MastermindViewModel
    var closeAction: () -> Void
    @Binding var wonGame: Bool

    var body: some View {
        Color.green.edgesIgnoringSafeArea(.all)
            .opacity(0.5)
        VStack {
            Text("Glückwunsch!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            Text("Du hast das den Code erraten!")
                .font(.title)
                .multilineTextAlignment(.center)
                .padding()
            Button(action: {
                viewModel.wonGame = false
                closeAction()
            }) {
                Text("Schließen")
            }
            .buttonStyle(PurpleButton())

        }
        .onAppear {
            wonGame = viewModel.wonGame
        }
    }
}

struct GameWonView_Previews: PreviewProvider {
    static var previews: some View {
        GameWonView(viewModel: MastermindViewModel(), closeAction: {}, wonGame: .constant(true))
    }
}
