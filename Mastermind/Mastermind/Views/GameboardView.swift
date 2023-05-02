//
//  GameboardView.swift
//  Mastermind
//
//  Created by Virzi, Valeria (SE-5/7AFI2) on 19.04.23.
//

import SwiftUI

struct GameboardView: View {
    @ObservedObject var viewModel: MastermindViewModel // um die Spiellogik auszuführen

    @State var lockedRows = 10
    @State var coloredRowIndex = 12
    
    // speichern den ausgewählten Kreis und seine Position
    @State var selectedColor = Color.red
    @State var selectedRowIndex = 11
    @State var selectedColumnIndex = 0

    var body: some View {
        VStack {
            ForEach(0 ..< 12) { rowIndex in
                HStack {
                    ForEach(0 ..< 4) { columnIndex in
                        // das ViewModel gibt für jede Position auf dem Spielbrett eine Farbe zurück
                        let circleColors = viewModel.getCircleColorsForRow(rowIndex)
                        let color = circleColors[columnIndex]

                        // speichert die Position und die Farbe vom Kreis beim antippen
                        GrayCircleView(color: color)
                            .onTapGesture {
                                selectedRowIndex = rowIndex
                                selectedColumnIndex = columnIndex
                            }
                            .opacity(rowIndex <= lockedRows ? 0.5 : 1.0) // reduziert die Deckkraft der Kreise in den gesperrten Reihen
                    }
                }
            }
            // zeigt das Farbmenu
            ColorMenuView(colors: viewModel.colors,
                          viewModel: viewModel,
                          selectedRowIndex: $selectedRowIndex,
                          selectedColumnIndex: $selectedColumnIndex,
                          lockedRows: $lockedRows,
                          coloredRowIndex: $coloredRowIndex)
            .padding(.top, 10)

            // zeigt den Submit-Button und den New game Button
            HStack {
                Button(action: {
                    viewModel.newGame()
                    lockedRows = 10
                    coloredRowIndex = 12
                }) {
                    Text("New Game")
                }
                .buttonStyle(PurpleButton())

                Button(action: {
                    lockedRows -= 1
                    selectedRowIndex -= 1
                    selectedColumnIndex = 0
                    coloredRowIndex -= 1
                }) {
                    Text("Submit")
                }
                .buttonStyle(PurpleButton())
            }
        }
        .padding()
    }
}


struct GameboardView_Previews: PreviewProvider {
    static var previews: some View {
        GameboardView(viewModel: MastermindViewModel())
    }
}
