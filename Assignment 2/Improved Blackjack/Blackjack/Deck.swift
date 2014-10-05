//
//  Deck.swift
//  Blackjack
//
//  Created by Kong Huang on 9/22/14.
//  Copyright (c) 2014 Kong Huang. All rights reserved.
//

import Foundation

class Deck{
    var cards: [Card] = []
    
    
    init(){
        cards.removeAll(keepCapacity: false)
        for suit in 0...3{
            for cardNumber in 1...13{
                cards.insert(Card(suit: suit, cardNumber: cardNumber), atIndex: 0)
            }
        }
        self.cards = shuffle(self.cards);
    }
    
    func drawCard() -> Card{
        var returnCard: Card!
        
        if(!cards.isEmpty){
            returnCard = cards.removeLast()
            return returnCard
        }
        else {
            self.reset()
            returnCard = cards.removeLast()
            return returnCard
        }
    }
    
    func shuffle<T>(var list: Array<T>) -> Array<T>{
        for i in 0..<list.count {
            let j = Int(arc4random_uniform(UInt32(list.count - i))) + i
            list.insert(list.removeAtIndex(j), atIndex: i)
        }
        println("DECK SHUFFLED")
        return list
    }
    
    func description() -> String{
        var deckList: String = "Deck: "
        for i in cards{
            deckList += i.description() + "\n"
        }
        return deckList
    }
    
    func reset(){
        cards.removeAll(keepCapacity: false)
        for suit in 0...3{
            for cardNumber in 1...13{
                cards.insert(Card(suit: suit, cardNumber: cardNumber), atIndex: 0)
            }
        }
        self.cards = shuffle(self.cards);
    }
}