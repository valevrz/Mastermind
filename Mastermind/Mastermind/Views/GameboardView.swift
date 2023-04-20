//
//  GameboardView.swift
//  Mastermind
//
//  Created by Virzi, Valeria (SE-5/7AFI2) on 19.04.23.
//

import SwiftUI

struct GameboardView: View {
    @ObservedObject var viewModel: MastermindViewModel //um die Spiellogik auszuführen
    
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
                                selectedRowIndex = rowIndex
                                selectedColumnIndex = columnIndex
                            }
                    }
                }
                .onAppear {
                    selectedColumnIndex = 0
                }
                .onChange(of: selectedRowIndex) { value in
                    selectedColumnIndex = 0
                }
            }
            //zeigt die Farben an, aus denen man auswählen kann
            HStack(spacing: 20) {
                ForEach(viewModel.colors, id: \.self) { color in
                    Button(action: {
                        //wenn man eine Farbe auswählt, wird sie dem Kreis an der ausgewählten Position zugewiesen
                        viewModel.selectColor(color, forRow: selectedRowIndex, column: selectedColumnIndex)
                        selectedColumnIndex += 1 //dadurch muss man den nächsten Kreis nicht anklicken, um ihn einzufärben, wählt man eine Farbe wird automatisch der Kreis daneben eingefärbt
                    }) {
                        Circle()
                            .fill(color)
                            .frame(width: 35, height: 35)
                            .overlay(Circle().stroke(Color.black, lineWidth: 2))
                    }
                    .disabled(selectedRowIndex <= 10)
                }
            }
            .padding(.top, 20)
        }
        .padding()
    }
}


struct GameboardView_Previews: PreviewProvider {
    static var previews: some View {
        GameboardView(viewModel: MastermindViewModel())
    }
}
