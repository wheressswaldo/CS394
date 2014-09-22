//
//  BlackjackModel.swift
//  Blackjack
//
//  Created by Kong Huang on 9/22/14.
//  Copyright (c) 2014 Kong Huang. All rights reserved.
//

import Foundation

class BlackjackModel{
    var playerHand: Hand
    var dealerHand: Hand
    var deck: Deck
    var blackjackModel: BlackjackModel? = nil
    
    init(){
        deck = Deck()
        playerHand = Hand()
        dealerHand = Hand()
        dealerHand.handClose = true
    }
    
    func setup(){
        playerHandDraws()
        dealerHandDraws()
        playerHandDraws()
        dealerHandDraws()
        
        println(playerHand.description())
        println(dealerHand.description())
        println(deck.description())
    }
    
    func dealerHandDraws(){
        dealerHand.addCard(deck.drawCard())
    }
    func playerHandDraws(){
        playerHand.addCard(deck.drawCard())
    }
    
    func gameEnds(ender:Int){
        switch ender{
        case 0:
            println("Player wins")
            playerHand.score = playerHand.score + 2
        case 1:
            println("Dealer wins")
            playerHand.score = playerHand.score - 2
        default:
            println("Draw")
        }
    }
    
    func dealerPlays() -> Int{
        while (dealerHand.getPipValue() < 17){
            dealerHandDraws()
        }
        if dealerHand.getPipValue() > 21{
            gameEnds(0)
            return 0
        }
        else if dealerHand.getPipValue() >= playerHand.getPipValue(){
            gameEnds(1)
            return 1
        }
        else{
            gameEnds(2)
            return 2
        }
    }
    
    func checkPlayerBust() -> Bool{
        if playerHand.getPipValue() > 21{
            playerHand.score = playerHand.score - 2
            return true
        }
        else{
            return false
        }
    }
    
    func newRound(){
        dealerHand.emptyHand()
        playerHand.emptyHand()
        playerHandDraws()
        dealerHandDraws()
        playerHandDraws()
        dealerHandDraws()
    }
    
}