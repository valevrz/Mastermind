//
//  ContentView.swift
//  Mastermind
//
//  Created by Virzi, Valeria (SE-5/7AFI2) on 18.04.23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Spacer()
            HStack {
                ForEach(0 ..< 4) { item in
                    GrayCircleView()
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
        }
        .padding()
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
