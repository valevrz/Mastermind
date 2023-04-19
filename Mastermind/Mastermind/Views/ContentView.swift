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
            MastermindView(circleColors: viewModel.circleColors)
            Spacer()
            ForEach(0 ..< 12) { item in
                HStack {
                    ForEach(0 ..< 4) { item in
                        GrayCircleView()
                    }
                }
            }
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
