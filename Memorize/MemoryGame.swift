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
    
    mutating func choose(_ card: Card) {
        print("chose \(card)")
        let chosenIndex = index(of: card)
        cards[chosenIndex].isFaceUp.toggle()
    }
       
    mutating func shuffle() {
        cards.shuffle()
        print(cards)
    }
    
    func index(of card: Card) -> Int {
        cards.firstIndex(where: { x in x.id == card.id})! // FIXME: what happens if I can't find it?
    }

    struct Card : Equatable, Identifiable, CustomDebugStringConvertible {
        var debugDescription: String {
            return "\(id): \(content) \(isFaceUp ? "up" : "down") \(isMatched ? "matched" : "")"
        }
        
        var isFaceUp = true
        var isMatched = false
        let content: CardContent
        
        var id: UUID = UUID()
    }
}

