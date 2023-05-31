//
//  GameWonView.swift
//  Mastermind
//
//  Created by Virzi, Valeria (SE-5/7AFI2) on 10.05.23.
//

import SwiftUI

struct GameLostView: View {
    @ObservedObject var viewModel: MastermindViewModel
    var closeAction: () -> Void
    @Binding var lostGame: Bool

    var body: some View {
        Color.red.edgesIgnoringSafeArea(.all)
            .opacity(0.5)
        VStack {
            Text("Versuche es nochmal!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            Text("Du hast das den Code nicht erraten!")
                .font(.title)
                .multilineTextAlignment(.center)
                .padding()
            Button(action: {
                viewModel.lostGame = false
                closeAction()
            }) {
                Text("Schließen")
            }
            .buttonStyle(PurpleButton())

        }
        .onAppear {
            lostGame = viewModel.lostGame
        }
    }
}

struct GameLostView_Previews: PreviewProvider {
    static var previews: some View {
        GameLostView(viewModel: MastermindViewModel(), closeAction: {}, lostGame: .constant(true))
    }
}
