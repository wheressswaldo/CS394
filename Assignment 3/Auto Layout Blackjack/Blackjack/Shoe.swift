//
//  Shoe.swift
//  Blackjack
//
//  Created by Kong Huang on 11/11/14.
//  Copyright (c) 2014 Kong Huang. All rights reserved.
//

import Foundation

class Shoe {
    init(deckCount:Int? = 4) {
        for var i = 0; i < deckCount; i++ {
            var d = Deck()
            for x in 0 ... d.cards.count - 1 {
                cards.append(d.cards[x])
            }
        }
        self.cards = shuffle(self.cards)
    }
    
    func shuffle<T>(var list: Array<T>) -> Array<T>{
        for i in 0..<list.count {
            let j = Int(arc4random_uniform(UInt32(list.count - i))) + i
            list.insert(list.removeAtIndex(j), atIndex: i)
        }
        println("DECK SHUFFLED")
        return list
    }
    
    func drawCard() -> Card{
        println(cards.count)
        
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
    
    func reset(){
        var deckCount = 4
        println("why")
        cards.removeAll(keepCapacity: false)
        for var i = 0; i < deckCount; i++ {
            var d = Deck()
            for x in 0 ... d.cards.count - 1 {
                cards.append(d.cards[x])
            }
        }
        self.cards = shuffle(self.cards)

    }
    
    func description() -> String{
        var deckList: String = "Deck: "
        for i in cards{
            deckList += i.description() + "\n"
        }
        return deckList
    }
    
    var cards = [Card]()
}