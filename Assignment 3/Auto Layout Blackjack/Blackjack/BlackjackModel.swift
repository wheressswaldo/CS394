//
//  BlackjackModel.swift
//  Blackjack
//
//  Created by Kong Huang on 9/22/14.
//  Copyright (c) 2014 Kong Huang. All rights reserved.
//

import Foundation

class BlackjackModel{
    var players: [Player] = []
    var dealer: Hand
    var shoe = Shoe()
    var blackjackModel: BlackjackModel? = nil
    
    init(){
        var newPlayer1 = Player(playerName: "John")
        var newPlayer2 = Player(playerName: "Bob")
        var AIPlayer = Player(playerName: "AI")

        players.insert(newPlayer1, atIndex: 0)
        players.insert(newPlayer2, atIndex: 0)
        players.insert(AIPlayer, atIndex: 0)
        dealer = Hand()
    }
    
    func setup(){
        println(shoe.description())
        playerHandDraws()
        dealerHandDraws()
        playerHandDraws()
        dealerHandDraws()
        dealer.cards[0].cardClose = true
    }
    
    func randomInt(min: Int, max:Int) -> Int{
        return min + Int(arc4random_uniform(UInt32(max - min + 1)))
    }
    
    func dealerHandDraws(){
        var chooseDeck = randomInt(0, max: 2)
        dealer.addCard(shoe.drawCard())
    }
    func playerHandDraws(){
        var chooseDeck = randomInt(0, max: 2)
        players[0].playerHand.addCard(shoe.drawCard())
        players[1].playerHand.addCard(shoe.drawCard())
        players[2].playerHand.addCard(shoe.drawCard())
    }
        
    func newRound(){
        dealer.emptyHand()
        players[0].playerHand.emptyHand()
        players[1].playerHand.emptyHand()
        players[2].playerHand.emptyHand()
        playerHandDraws()
        dealerHandDraws()
        playerHandDraws()
        dealerHandDraws()
    }
    
}