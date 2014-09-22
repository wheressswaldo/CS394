//
//  ViewController.swift
//  Blackjack
//
//  Created by Kong Huang on 9/21/14.
//  Copyright (c) 2014 Kong Huang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var blackjack = BlackjackModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        blackjack.setup()
        showDealerHand(blackjack.dealerHand)
        showPlayerHand(blackjack.playerHand)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showHandAtyPos(givenHand:Hand, yPos:Int){

        for index in 0..<givenHand.countCards(){
            var tempCard:Card = givenHand.getCardAtIndex(index)
            var tempFileName:String = tempCard.fileName()
            
            var glfYPos = CGFloat(yPos)
            var sum:CGFloat = CGFloat((index*40) + 20)
            var imageView = UIImageView(frame: CGRectMake(sum, glfYPos, 71, 96))
            var image = UIImage (named: tempFileName)
            imageView.image = image
            self.view.addSubview(imageView)
        }
    }
    
    func showDealerHand(givenHand:Hand){
        showHandAtyPos(givenHand, yPos:  80)
    }
    
    func showPlayerHand(givenHand:Hand){
        showHandAtyPos(givenHand, yPos:  290)
    }
    
    @IBAction func hitCard(sender : AnyObject){
        blackjack.playerHandDraws()
        println(blackjack.playerHand.description())
        showPlayerHand(blackjack.playerHand)
    }
    @IBAction func playerStands(sender : AnyObject){
        blackjack.dealerHand.cards[0].cardClose = false
        blackjack.dealerHand.handClose = false
        showDealerHand(blackjack.dealerHand)
        while (blackjack.dealerHand.getPipValue() < 17){
            blackjack.dealerHandDraws()
            showDealerHand(blackjack.dealerHand)
            sleep(2)
        }
        blackjack.dealerPlays()
    }
    
}

