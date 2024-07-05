//
//  CardView.swift
//  Memorize
//
//  Created by Charles Kincy on 2024-07-04.
//

import SwiftUI

struct CardView: View {
    typealias Card = MemoryGame<String>.Card
    
    let card: Card
    
    init(_ card: Card) {
        self.card = card
    }
    
    var body: some View {
        Pie(endAngle: .degrees(240))
            .opacity(Constants.Pie.opacity)
            .overlay(
                Text(card.content)
                    .font(.system(size: Constants.FontSize.largest))
                    .minimumScaleFactor(Constants.FontSize.scaleFactor)
                    .aspectRatio(1, contentMode: .fit)
                    .padding(Constants.inset)
                    .rotationEffect(.degrees(card.isMatched ? 360 : 0))
                    .animation(.spin(duration: 1), value: card.isMatched)
            )
            .padding(Constants.Pie.inset)
            .cardify(isFaceUp: card.isFaceUp)
            .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
}

extension Animation {
    static func spin(duration: TimeInterval) -> Animation {
        .linear(duration: duration).repeatForever(autoreverses: false)
    }
}

private struct Constants {
    static let cornerRadius: CGFloat = 12
    static let lineWidth: CGFloat = 2
    static let inset: CGFloat = 5
    struct FontSize {
        static let largest: CGFloat = 200
        static let smallest: CGFloat = 10
        static let scaleFactor = smallest / largest
    }
    struct Pie {
        static let opacity: CGFloat = 0.4
        static let inset: CGFloat = 5
    }
}

#Preview {
    VStack {
        HStack {
            CardView(CardView.Card(isFaceUp: true, content: "X", id: UUID()))
                .padding()
                .foregroundColor(.green)
            CardView(CardView.Card(isFaceUp: false, content: "X", id: UUID()))
                .padding()
                .foregroundColor(.green)
        }
        HStack {
            CardView(CardView.Card(isFaceUp: true, isMatched: true, content: "X", id: UUID()))
                .padding()
                .foregroundColor(.red)
            CardView(CardView.Card(isFaceUp: false, isMatched: true, content: "X", id: UUID()))
                .padding()
                .foregroundColor(.red)
        }
    }
}
