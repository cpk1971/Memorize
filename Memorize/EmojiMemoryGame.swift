//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Charles Kincy on 2024-06-18.
//
//  (This is the ViewModel)
//

/*
 let themes = [ "Halloween": ["👻", "🎃", "🕷️", "😈", "💀", "🕸️", "🧙‍♀️", "🐈‍⬛", "👹", "☠️", "🍭"],
                "Sports":   ["⚽️", "🏀", "🏈", "⚾️", "🥎", "🎾", "🏐", "🏉", "🏓", "🎳"],
                "Animals": ["🐱", "🐶", "🐰", "🐭", "🐹", "🦊", "🐻", "🐻‍❄️", "🐼"], ]
 */

import SwiftUI

class EmojiMemoryGame : ObservableObject {
    private static let EMOJIS = ["👻", "🎃", "🕷️", "😈", "💀", "🕸️", "🧙‍♀️", "🐈‍⬛", "👹", "☠️", "🍭"]
    
    private static func createCardContent(forPairAtIndex index: Int) -> String {
        (index >= 0 && index < EMOJIS.count) ? EMOJIS[index] : "⁉️"
    }

    @Published private var model = MemoryGame<String>(numberOfPairsOfCards: 8, contentFactory: createCardContent)
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    // MARK: - Intents
    
    // This is called an "intent" function
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func shuffle() {
        model.shuffle()
    }
}
