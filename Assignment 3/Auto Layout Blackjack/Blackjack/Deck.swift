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
    }
}