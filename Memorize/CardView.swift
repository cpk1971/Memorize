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
        ZStack {
            let base = RoundedRectangle(cornerRadius: Constants.cornerRadius)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: Constants.lineWidth)
                Text(card.content)
                    .font(.system(size: Constants.FontSize.largest))
                    .minimumScaleFactor(Constants.FontSize.scaleFactor)
                    .aspectRatio(1, contentMode: .fit)
                    .padding(Constants.inset)
            }
            .opacity(card.isFaceUp ? 1 : 0)
            base.fill().opacity(card.isFaceUp ? 0 : 1)
        }.opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
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
