//
//  ViewController.swift
//  Blackjack
//
//  Created by Kong Huang on 9/21/14.
//  Copyright (c) 2014 Kong Huang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var scoreLabel : UILabel!
    
    var count:Int = 0
    var blackjack = BlackjackModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        blackjack.setup()
        showDealerHand(blackjack.dealerHand)
        showPlayerHand(blackjack.playerHand)
        scoreLabel.text = String(blackjack.playerHand.score)
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
        if blackjack.checkPlayerBust(){
            scoreLabel.text = String(blackjack.playerHand.score)
            var alert = UIAlertController(title: "Round Over", message: "You went over 21!", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Click for next round", style: UIAlertActionStyle.Default, handler: {(action)
            -> Void in
                self.blackjack.newRound()
                self.showPlayerHand(self.blackjack.playerHand)
                self.showDealerHand(self.blackjack.dealerHand)
                self.count = self.count + 1
            
                if self.count > 5{
                    self.blackjack.deck.reset()
                    self.count = 0
                }
            }))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func playerStands(sender : AnyObject){
        blackjack.dealerHand.cards[0].cardClose = false
        blackjack.dealerHand.handClose = false
        showDealerHand(blackjack.dealerHand)
        while (blackjack.dealerHand.getPipValue() < 17){
            blackjack.dealerHandDraws()
            showDealerHand(blackjack.dealerHand)
        }
        
        var alertControl:Int = blackjack.dealerPlays()
        
        popUpBox(alertControl)

    }
    
    func popUpBox(alertInt:Int){
        var titles = "Round over"
        var messages = ""
        if alertInt == 0 {
            messages = "Player wins"
            scoreLabel.text = String(blackjack.playerHand.score)
        } else if alertInt == 1{
            messages = "Dealer wins"
            scoreLabel.text = String(blackjack.playerHand.score)
        }
        else if alertInt == 2{
            messages = "It's a draw!"
            scoreLabel.text = String(blackjack.playerHand.score)
        }
        
        var alert = UIAlertController(title: titles, message: messages, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Click for next round", style: UIAlertActionStyle.Default, handler: {(action)
            -> Void in
            self.blackjack.newRound()
            self.showPlayerHand(self.blackjack.playerHand)
            self.showDealerHand(self.blackjack.dealerHand)
            self.count = self.count + 1
            
            if self.count > 5{
                self.blackjack.deck.reset()
                self.count = 0
            }
        }))
        self.presentViewController(alert, animated: true, completion: nil)
    }

}

