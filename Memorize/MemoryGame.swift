//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Charles Kincy on 2024-06-18.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: [Card]
    
    init(numberOfPairsOfCards: Int, contentFactory: (Int) -> CardContent) {
        let content = (0..<max(2,numberOfPairsOfCards)).map(contentFactory)
        cards = (content + content).map { content in
            Card(content: content)
        }
    }
    
    func choose(_ card: Card) {
        
    }
    
    mutating func shuffle() {
        cards.shuffle()
        print(cards)
    }

    struct Card : Equatable {
        var isFaceUp = true
        var isMatched = false
        let content: CardContent
    }
}

