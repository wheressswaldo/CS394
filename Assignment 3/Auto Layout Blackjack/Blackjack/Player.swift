//
//  Player.swift
//  Blackjack
//
//  Created by Kong Huang on 11/11/14.
//  Copyright (c) 2014 Kong Huang. All rights reserved.
//

import Foundation

class Player {
    init(playerName:String) {
        self.playerName = playerName
        playerBet = 1
        playerPocket = 100
        playerHand = Hand()
    }
    
    var playerName:String
    var playerBet:Int
    var playerPocket:Int

    var playerHand:Hand
}