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
        TimelineView(.animation) {timeline in
            if card.isFaceUp || !card.isMatched {
                Pie(endAngle: .degrees(card.bonusPercentRemaining * 360))
                    .opacity(Constants.Pie.opacity)
                    .overlay(cardContents .padding(Constants.inset))
                    .padding(Constants.Pie.inset)
                    .cardify(isFaceUp: card.isFaceUp)
                    .transition(.slide)
            } else {
                Color.clear
            }
        }
    }
    
    var cardContents: some View {
        Text(card.content)
            .font(.system(size: Constants.FontSize.largest))
            .minimumScaleFactor(Constants.FontSize.scaleFactor)
            .aspectRatio(1, contentMode: .fit)
            .rotationEffect(.degrees(card.isMatched ? 360 : 0))
            .animation(.spin(duration: 1), value: card.isMatched)
    }
}

extension Animation {
    static func spin(duration: TimeInterval) -> Animation {
        .linear(duration: duration).repeatCount(2, autoreverses: false)
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
