//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Charles Kincy on 2024-06-16.
//

import SwiftUI

struct EmojiMemoryGameView: View {
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
                .aspectRatio(cardAspectRatio, contentMode: .fit)
                .padding(4)
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        viewModel.choose(card)
                    }
                }
        }
    }
    
    
    init(viewModel: EmojiMemoryGame) {
        self.viewModel = viewModel
    }
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
