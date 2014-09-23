//
//  Hand.swift
//  Blackjack
//
//  Created by Kong Huang on 9/22/14.
//  Copyright (c) 2014 Kong Huang. All rights reserved.
//

import Foundation

class Hand{
    var cards: [Card] = []
    var handClose: Bool
    var score: Int
    
    init(){
        handClose = false
        score = 100
    }
    
    func countCards() -> Int{
        return cards.count
    }
    
    func addCard(newCard: Card){
        if handClose == false || self.countCards() == 0{
            cards.insert(newCard, atIndex: 0)
        }
        else{
            newCard.cardClose = true
            cards.insert(newCard, atIndex: 0)
        }
    }
    
    func getPipValue() -> Int{
        var aValue = 0
        var aceCount: Int = 0
        
        for i in 0..<cards.count{
            aValue = aValue + cards[i].pipValue
            if cards[i].cardNumber == 1{
                aceCount++
            }
        }
        while (aValue > 21 && aceCount>0){
            aValue = aValue - 10
            aceCount = aceCount - 1
        }
        return aValue
    }
    
    func getCardAtIndex(index: Int) -> Card{
        return cards[index]
    }
    
    func description() -> String{
        var handList: String = "Hand: "
        for i in cards{
            handList += i.description() + "\n"
        }
        return handList
    }
    
    func emptyHand(){
        cards.removeAll(keepCapacity: false)
    }
    
}