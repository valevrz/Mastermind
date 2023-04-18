//
//  ContentView.swift
//  Mastermind
//
//  Created by Virzi, Valeria (SE-5/7AFI2) on 18.04.23.
//

import SwiftUI

struct ContentView: View {
    let colors: [Color] = [.red, .green, .blue, .yellow, .purple, .indigo]
    @State var circleColors: [Color] = []

    init() {
            _circleColors = State(initialValue: colors.shuffled())
        }

    var body: some View {
        VStack {
            Spacer()
            HStack {
                ForEach(0..<4) { index in
                    Circle()
                        .foregroundColor(circleColors.indices.contains(index) ? circleColors[index] : .gray)
                        .overlay(Circle().stroke(Color.black, lineWidth: 2))
                        .frame(width: 40, height: 40)
                }
            }
            Spacer()
            ForEach(0 ..< 12) { item in
                HStack {
                    ForEach(0 ..< 4) { item in
                        GrayCircleView()
                    }
                }
            }
            Button("New Game") {
                circleColors = colors.shuffled()
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
