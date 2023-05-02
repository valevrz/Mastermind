//
//  FeedbackCirclesView.swift
//  Mastermind
//
//  Created by Virzi, Valeria (SE-5/7AFI2) on 27.04.23.
//

import SwiftUI

struct FeedbackCirclesView: View {
    var feedbackColors: [Color]

    var body: some View {
        HStack {
            ForEach(feedbackColors) { color in
                Circle()
                    .fill(color)
                    .overlay(Circle().stroke(Color.black, lineWidth: 2))
                    .frame(width: 10.0)
            }
        }
    }
}

extension Color: Identifiable{
    public var id: UUID {
        UUID()
    }
}

struct FeedbackCirclesView_Previews: PreviewProvider {
    static var previews: some View {
        FeedbackCirclesView(feedbackColors: [.red, .red, .white, .red])
    }
}
