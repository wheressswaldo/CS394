//
//  BlackjackModel.swift
//  Blackjack
//
//  Created by Kong Huang on 9/22/14.
//  Copyright (c) 2014 Kong Huang. All rights reserved.
//

import Foundation

class BlackjackModel{
    var playerHands: [Hand] = []
    var dealerHand: Hand
    var decks: [Deck] = []
    var blackjackModel: BlackjackModel? = nil
    
    init(){
        var newDeck = Deck()
        decks.insert(newDeck, atIndex: 0)
        newDeck.reset()
        decks.insert(newDeck, atIndex: 0)
        newDeck.reset()
        decks.insert(newDeck, atIndex: 0)
        var newPlayer1 = Hand()
        var newPlayer2 = Hand()
        var newPlayer3 = Hand()
        // 3 players
        playerHands.insert(newPlayer1, atIndex: 0)
        playerHands.insert(newPlayer2, atIndex: 0)
        playerHands.insert(newPlayer3, atIndex: 0)
        dealerHand = Hand()
        dealerHand.handClose = true
    }
    
    func setup(){
        println(decks[0].description())
        playerHandDraws()
        dealerHandDraws()
        playerHandDraws()
        dealerHandDraws()
        println("Player ")
        print(playerHands[0].description())
        println("Dealer ")
        print(dealerHand.description())
    }
    
    func randomInt(min: Int, max:Int) -> Int{
        return min + Int(arc4random_uniform(UInt32(max - min + 1)))
    }
    
    func dealerHandDraws(){
        var chooseDeck = randomInt(0, max: 2)
        dealerHand.addCard(decks[chooseDeck].drawCard())
    }
    func playerHandDraws(){
        var chooseDeck = randomInt(0, max: 2)
        playerHands[0].addCard(decks[chooseDeck].drawCard())
        playerHands[1].addCard(decks[chooseDeck].drawCard())
        playerHands[2].addCard(decks[chooseDeck].drawCard())
    }
    
    func gameEnds(ender:Int, player:Int){
        switch ender{
        case 0:
            println("Player wins")
            playerHands[player].score = playerHands[player].score + 2
        case 1:
            println("Dealer wins")
            playerHands[player].score = playerHands[player].score - 1
        default:
            println("Draw")
        }
    }
    
    func dealerPlays() -> Int{
        while (dealerHand.getPipValue() < 17){
            dealerHandDraws()
        }
        if dealerHand.getPipValue() > 21 || dealerHand.getPipValue() < playerHands[0].getPipValue(){
            gameEnds(0, player: 0)
            return 0
        }
        else if dealerHand.getPipValue() > playerHands[0].getPipValue(){
            gameEnds(1, player: 0)
            return 1
        }
        else{
            gameEnds(2, player: 0)
            return 2
        }
    }
    
    func checkPlayerBust(player:Int) -> Bool{
        if playerHands[player].getPipValue() > 21{
            playerHands[player].score = playerHands[player].score - 1
            return true
        }
        else{
            return false
        }
    }
    
    func checkBlackJack(player:Int) -> Bool{
        if playerHands[player].getPipValue() == 21{
            playerHands[player].score = playerHands[player].score + 2
            return true
        }
        else{
            return false
        }
    }
    
    func newRound(){
        dealerHand.emptyHand()
        playerHands[0].emptyHand()
        playerHands[1].emptyHand()
        playerHands[2].emptyHand()
        playerHandDraws()
        dealerHandDraws()
        playerHandDraws()
        dealerHandDraws()
    }
    
}