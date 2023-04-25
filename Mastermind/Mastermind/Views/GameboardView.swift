//
//  GameboardView.swift
//  Mastermind
//
//  Created by Virzi, Valeria (SE-5/7AFI2) on 19.04.23.
//

import SwiftUI

struct GameboardView: View {
    @ObservedObject var viewModel: MastermindViewModel //um die Spiellogik auszuführen

    @State private var isRowLocked = false //wird true, wenn der Submit-Button angeklickt wird
    @State private var lockedRows = 10
    
    //speichern den ausgewählten Kreis und seine Position
    @State private var selectedColor = Color.red
    @State private var selectedRowIndex = 11
    @State private var selectedColumnIndex = 0

    var body: some View {
        VStack {
            ForEach(0 ..< 12) { rowIndex in
                HStack {
                    ForEach(0 ..< 4) { columnIndex in
                        //das ViewModel gibt für jede Position auf dem Spielbrett eine Farbe zurück
                        let circleColors = viewModel.getCircleColorsForRow(rowIndex)
                        let color = circleColors[columnIndex]

                        //speichert die Position und die Farbe vom Kreis beim antippen
                        GrayCircleView(color: color)
                            .onTapGesture {
                                if !isRowLocked {
                                    selectedRowIndex = rowIndex
                                    selectedColumnIndex = columnIndex
                                }
                            }
                    }
                }
                .onAppear {
                    selectedColumnIndex = 0
                    isRowLocked = false //entsperrt die aktuelle Reihe
                }
            }
            //zeigt die Farben an, aus denen man auswählen kann
            HStack(spacing: 10) {
                ForEach(viewModel.colors, id: \.self) { color in
                    Button(action: {
                        //wenn man eine Farbe auswählt, wird sie dem Kreis an der ausgewählten Position zugewiesen
                        viewModel.selectColor(color, forRow: selectedRowIndex, column: selectedColumnIndex)

                        //dadurch muss man den nächsten Kreis nicht anklicken, um ihn einzufärben, wählt man eine Farbe wird automatisch der Kreis daneben eingefärbt
                        selectedColumnIndex += 1
                    }) {
                        Circle()
                            .fill(color)
                            .frame(width: 35, height: 35)
                            .overlay(Circle().stroke(Color.black, lineWidth: 2))
                    }
                    .disabled(selectedRowIndex <= lockedRows || isRowLocked) //sperrt die Reihen 1-11
                }
            }
            .padding(.top, 10)

            //zeigt den Submit-Button und den New game Button
            HStack {
            Button(action: {
                viewModel.newGame()
                isRowLocked = false
            }) {
                Text("New Game")
                }
                .font(.title3)
                .bold()
                .foregroundColor(.white)
                .padding(.vertical, 10)
                .padding(.horizontal, 20)
                .background(Color.purple)
                .cornerRadius(10)
                .padding(.top, 10)

            Button(action: {
                isRowLocked = true //sperrt die aktuelle Reihe
                lockedRows -= 1
            }) {
                Text("Submit")
                    .font(.title3)
                    .bold()
                    .foregroundColor(.white)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 20)
                    .background(Color.purple)
                    .cornerRadius(10)
                }
                .padding(.top, 10)
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
