//
//  Card.swift
//  Blackjack
//
//  Created by Kong Huang on 9/21/14.
//  Copyright (c) 2014 Kong Huang. All rights reserved.
//

import Foundation

class Card{
    
    var suit: Int
    var cardNumber: Int
    var cardClose: Bool
    
    var pipValue: Int {
        get {
            if cardClose == true{
                return 0
            }
            if cardNumber >= 10{
                return 10
            }
            else if cardNumber == 1{
                return 11
            }
            else{
                return cardNumber
            }
        }
    }
    
    init(suit: Int, cardNumber: Int){
        self.suit = suit
        self.cardNumber = cardNumber
        self.cardClose = false
    }
    
    func suitAsString() -> String{
        switch suit{
        case 0:
            return "diamond"
        case 1:
            return "heart"
        case 2:
            return "club"
        case 3:
            return "spade"
        default:
            return ""
        }
    }
    
    func cardNumberAsString() -> String{
        switch cardNumber{
        case 1:
            return "Ace"
        case 11:
            return "Jack"
        case 12:
            return "Queen"
        case 13:
            return "King"
        default:
            return String(cardNumber)
        }
    }
    
    func description() -> String{
        return "\(cardNumberAsString()) of \(suitAsString())"
    }
    
    func fileName() -> String{
        if cardClose == true{
            return "closed.gif"
        }
        else{
            var fileName:String = suitAsString() + String(cardNumber) + ".gif"
            return fileName
        }
    }
    
}