//
//  ContentView.swift
//  Memorize
//
//  Created by Charles Kincy on 2024-06-16.
//

import SwiftUI

struct ContentView: View {
    let themes = [ "Halloween": ["👻", "🎃", "🕷️", "😈", "💀", "🕸️", "🧙‍♀️", "🐈‍⬛", "👹", "☠️", "🍭"],
                   "Sports":   ["⚽️", "🏀", "🏈", "⚾️", "🥎", "🎾", "🏐", "🏉", "🏓", "🎳"],
                   "Animals": ["🐱", "🐶", "🐰", "🐭", "🐹", "🦊", "🐻", "🐻‍❄️", "🐼"], ]
    
    let themeLabels = [ "Halloween": "calendar", "Sports": "figure.soccer", "Animals": "cat.fill"]
        
    @State var theme = "Halloween"
    @State var currentEmojis: [String] = []
    
    func buildEmojis(for theme: String) -> [String] {
        (themes[theme]! + themes[theme]!).shuffled()
    }
    
    var body: some View {
        VStack {
            Text("Memorize!").font(.largeTitle)
            ScrollView {
                cards
            }
            Spacer()
            themeSelectors.font(.title)
            .imageScale(.large)
            .font(.largeTitle)
    }
        .padding()
    }
    
    var themeSelectors: some View {
        HStack {
            ForEach(themes.keys.sorted(by:<), id: \.self) { name in
                Spacer()
                HStack(alignment: .lastTextBaseline, content: {
                    Button(action: {
                        theme = name
                        currentEmojis = buildEmojis(for: theme)
                    }, label: {
                        VStack {
                            Image(systemName: themeLabels[name]!).font(.largeTitle)
                            Text(name).font(.caption)
                        }
                    })
                })
                Spacer()
            }
        }
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum:60))]) {
            ForEach(0..<currentEmojis.count, id: \.self) { index in
                CardView(content: currentEmojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(.orange)
    }
}

struct CardView: View {
    let content: String
    @State var isFaceUp = true
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12.0)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
        }.onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}
