//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Charles Kincy on 2024-06-16.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    typealias Card = MemoryGame<String>.Card
    
    @ObservedObject var viewModel: EmojiMemoryGame
    private let cardAspectRatio: CGFloat = 4/5
    
    var body: some View {
        VStack {
            Text("Memorize!").font(.largeTitle)
            cards
                .foregroundColor(viewModel.color)
            HStack {
                score
                Spacer()
                shuffle
            }
        }
        .padding()
    }
    
    private var score: some View {
        Text("Score: \(viewModel.score)")
            .font(.largeTitle)
            .animation(nil)
    }
    
    private var shuffle: some View {
        Button("Shuffle") {
            withAnimation {
                viewModel.shuffle()
            }
        }
    }
    
    private var cards: some View {
        AspectVGrid(viewModel.cards, aspectRatio: cardAspectRatio) { card in
            CardView(card)
                .padding(4)
                .overlay(FlyingNumber(number: scoreChange(causedBy: card)))
                .zIndex(scoreChange(causedBy: card) != 0 ? 1000 : 0)
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        let scoreBeforeChoosing = viewModel.score
                        viewModel.choose(card)
                        let scoreChange = viewModel.score - scoreBeforeChoosing
                        lastScoreChange = (scoreChange, card.id)
                    }
                }
        }
    }
    
    @State private var lastScoreChange: (Int, causedByCardId: Card.ID)
        = (0, causedByCardId: UUID())
    
    private func scoreChange(causedBy card: Card) -> Int {
        let (amount, id) = lastScoreChange
        return card.id == id ? amount : 0
    }
    
    init(viewModel: EmojiMemoryGame) {
        self.viewModel = viewModel
    }
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
