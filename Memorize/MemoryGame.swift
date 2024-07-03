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
    
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter { cards[$0].isFaceUp }.only }
        set { cards.indices.forEach { cards[$0].isFaceUp = ($0 == newValue) } }
    }
    
    mutating func choose(_ card: Card) {
        print("chose \(card)")
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
                if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                    if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                    }
                } else {
                    indexOfTheOneAndOnlyFaceUpCard = chosenIndex
                }
                cards[chosenIndex].isFaceUp = true
            }
        }
    }
       
    mutating func shuffle() {
        cards.indices.forEach {
            cards[$0].isMatched = false
            cards[$0].isFaceUp = false
        }
        cards.shuffle()
        print(cards)
    }
    
    struct Card : Equatable, Identifiable, CustomDebugStringConvertible {
        var debugDescription: String {
            return "\(id): \(content) \(isFaceUp ? "up" : "down") \(isMatched ? "matched" : "")"
        }
        
        var isFaceUp = false
        var isMatched = false
        let content: CardContent
        
        var id = UUID()
    }
}

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
