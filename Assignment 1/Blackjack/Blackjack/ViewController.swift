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
    @IBOutlet var playerLabel : UILabel!
    @IBOutlet var dealerLabel : UILabel!
    
    var count:Int = 0
    var blackjack = BlackjackModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        blackjack.setup()
        showDealerHand(blackjack.dealerHand)
        showPlayerHand(blackjack.playerHand)
        playerLabel.text = "Player (" + String(blackjack.playerHand.getPipValue()) + ")"
        dealerLabel.text = "Dealer (" + String(blackjack.dealerHand.getPipValue()) + ")"
        scoreLabel.text = String(blackjack.playerHand.score)
        // Do any additional setup after loading the view, typically from a nib.
        if blackjack.checkBlackJack(){
            popUpBox(5)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func clean(){
        for view in self.view.subviews{
            if view is UIImageView{
                view.removeFromSuperview()
            }
        }
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
        println("Player ")
        print(blackjack.playerHand.description())
        playerLabel.text = "Player (" + String(blackjack.playerHand.getPipValue()) + ")"
        showPlayerHand(blackjack.playerHand)
        if blackjack.checkPlayerBust(){
            popUpBox(3)
        }
        else if blackjack.checkBlackJack(){
            popUpBox(4)
        }
        
    }
    
    @IBAction func playerStands(sender : AnyObject){
        blackjack.dealerHand.cards[0].cardClose = false
        blackjack.dealerHand.handClose = false
        showDealerHand(blackjack.dealerHand)
        while (blackjack.dealerHand.getPipValue() < 17){
            blackjack.dealerHandDraws()
            println("Dealer ")
            print(blackjack.dealerHand.description())
            showDealerHand(blackjack.dealerHand)
            dealerLabel.text = "Dealer (" + String(blackjack.dealerHand.getPipValue()) + ")"
        }
        var alertControl:Int = blackjack.dealerPlays()
        
        popUpBox(alertControl)

    }
    
    func popUpBox(alertInt:Int){
        var titles = "Round over"
        var messages = ""
        if alertInt == 0 {
            messages = "You win!"
            scoreLabel.text = String(blackjack.playerHand.score)
        } else if alertInt == 1{
            messages = "Dealer wins"
            scoreLabel.text = String(blackjack.playerHand.score)
        }
        else if alertInt == 2{
            messages = "It's a draw!"
            scoreLabel.text = String(blackjack.playerHand.score)
        }
        else if alertInt == 3{
            messages = "You went over 21!"
            scoreLabel.text = String(blackjack.playerHand.score)
        }
        else if alertInt == 4{
            messages = "Twenty One!! You win!"
            scoreLabel.text = String(blackjack.playerHand.score)
        }
        else if alertInt == 5{
            messages = "BLACKJACK!!!!"
            scoreLabel.text = String(blackjack.playerHand.score)
        }
        
        var alert = UIAlertController(title: titles, message: messages, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Click for next round", style: UIAlertActionStyle.Default, handler: {(action)
            -> Void in
            self.clean()
            self.blackjack.newRound()
            self.showPlayerHand(self.blackjack.playerHand)
            self.showDealerHand(self.blackjack.dealerHand)
            println("Player ")
            print(self.blackjack.playerHand.description())
            println("Dealer ")
            print(self.blackjack.dealerHand.description())
            self.playerLabel.text = "Player (" + String(self.blackjack.playerHand.getPipValue()) + ")"
            self.dealerLabel.text = "Dealer (" + String(self.blackjack.dealerHand.getPipValue()) + ")"
            self.count = self.count + 1
            
            if self.count > 5{
                self.blackjack.deck.reset()
                self.count = 0
            }
        }))
        self.presentViewController(alert, animated: true, completion: nil)
    }

}

