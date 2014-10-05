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
    var currentPlayer:Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        blackjack.setup()
        showDealerHand(blackjack.dealerHand)
        showPlayerHand(blackjack.playerHands[currentPlayer])
        if currentPlayer==0{
            showInactiveHand(blackjack.playerHands[1], adjustment: 0)
            showInactiveHand(blackjack.playerHands[2], adjustment: 1)
        }
        else if currentPlayer==1{
            showInactiveHand(blackjack.playerHands[0], adjustment: 0)
            showInactiveHand(blackjack.playerHands[2], adjustment: 1)
        }
        else if currentPlayer==2{
            showInactiveHand(blackjack.playerHands[0], adjustment: 0)
            showInactiveHand(blackjack.playerHands[1], adjustment: 1)
        }
        playerLabel.text = "Current Player: " + String(currentPlayer+1) +
                            " (" + String(blackjack.playerHands[currentPlayer].getPipValue()) + ")"
        dealerLabel.text = "Dealer (" + String(blackjack.dealerHand.getPipValue()) + ")"
        scoreLabel.text = String(blackjack.playerHands[currentPlayer].score)
        // Do any additional setup after loading the view, typically from a nib.
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
    
    func showHandAtyPos(givenHand:Hand, xPos:Int, yPos:Int){
        for index in 0..<givenHand.countCards(){
            var tempCard:Card = givenHand.getCardAtIndex(index)
            var tempFileName:String = tempCard.fileName()
            
            var glfYPos = CGFloat(yPos)
            var adjustment = 0
            if givenHand.countCards() > 2{
                adjustment = 10 * givenHand.countCards()
            }
            var sum:CGFloat = CGFloat((index*40) + 20) + CGFloat(xPos - adjustment)
            var imageView = UIImageView(frame: CGRectMake(sum, glfYPos, 71, 96))
            var image = UIImage (named: tempFileName)
            imageView.image = image
            self.view.addSubview(imageView)
        }
    }
    
    func showInactiveHandAtyPos(givenHand:Hand, xPos:Int, yPos:Int){
        for index in 0...1{
            var tempFileName:String = "closed.gif"
            
            var glfYPos = CGFloat(yPos)
            var adjustment = 0
            if givenHand.countCards() > 2{
                adjustment = 10 * givenHand.countCards()
            }
            var sum:CGFloat = CGFloat((index*25) + 20) + CGFloat(xPos - adjustment)
            var imageView = UIImageView(frame: CGRectMake(sum, glfYPos, 71, 96))
            var image = UIImage (named: tempFileName)
            imageView.image = image
            self.view.addSubview(imageView)
        }
    }
    
    func showDealerHand(givenHand:Hand){
        showHandAtyPos(givenHand, xPos:  75, yPos:  217)
    }
    
    func showPlayerHand(givenHand:Hand){
        showHandAtyPos(givenHand, xPos:  75, yPos:  360)
    }
    
    func showInactiveHand(givenHand:Hand, adjustment: Int){
        showInactiveHandAtyPos(givenHand, xPos: 0 + (adjustment * 175), yPos: 80)
    }
    
    
    @IBAction func hitCard(sender : AnyObject){
        blackjack.playerHandDraws()
        println("Player ")
        print(blackjack.playerHands[currentPlayer].description())
        playerLabel.text = "Current Player: " + String(currentPlayer+1) +
            " (" + String(blackjack.playerHands[currentPlayer].getPipValue()) + ")"
        showPlayerHand(blackjack.playerHands[currentPlayer])
        if blackjack.checkPlayerBust(currentPlayer){
            popUpBox(3)
        }
        else if blackjack.checkBlackJack(currentPlayer){
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
            scoreLabel.text = String(blackjack.playerHands[currentPlayer].score)
        } else if alertInt == 1{
            messages = "Dealer wins"
            scoreLabel.text = String(blackjack.playerHands[currentPlayer].score)
        }
        else if alertInt == 2{
            messages = "It's a draw!"
            scoreLabel.text = String(blackjack.playerHands[currentPlayer].score)
        }
        else if alertInt == 3{
            messages = "You went over 21!"
            scoreLabel.text = String(blackjack.playerHands[currentPlayer].score)
        }
        else if alertInt == 4{
            messages = "Twenty One!! You win!"
            scoreLabel.text = String(blackjack.playerHands[currentPlayer].score)
        }
        else if alertInt == 5{
            messages = "BLACKJACK!!!!"
            scoreLabel.text = String(blackjack.playerHands[currentPlayer].score)
        }
        
        var alert = UIAlertController(title: titles, message: messages, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Click for next round", style: UIAlertActionStyle.Default, handler: {(action)
            -> Void in
            self.clean()
            self.blackjack.newRound()
            self.showPlayerHand(self.blackjack.playerHands[self.currentPlayer])
            self.showDealerHand(self.blackjack.dealerHand)
            
            if self.currentPlayer==0{
                self.showInactiveHand(self.blackjack.playerHands[1], adjustment: 0)
                self.showInactiveHand(self.blackjack.playerHands[2], adjustment: 1)
            }
            else if self.currentPlayer==1{
                self.showInactiveHand(self.blackjack.playerHands[0], adjustment: 0)
                self.showInactiveHand(self.blackjack.playerHands[2], adjustment: 1)
            }
            else if self.currentPlayer==2{
                self.showInactiveHand(self.blackjack.playerHands[0], adjustment: 0)
                self.showInactiveHand(self.blackjack.playerHands[1], adjustment: 1)
            }
            
            
            println("Player ")
            print(self.blackjack.playerHands[self.currentPlayer].description())
            println("Dealer ")
            print(self.blackjack.dealerHand.description())
            self.playerLabel.text = "Current Player: " + String(self.currentPlayer+1) +
                " (" + String(self.blackjack.playerHands[self.currentPlayer].getPipValue()) + ")"
            self.dealerLabel.text = "Dealer (" + String(self.blackjack.dealerHand.getPipValue()) + ")"
            self.count = self.count + 1
            
            if self.count > 20{
                self.blackjack.decks[0].reset()
                self.blackjack.decks[1].reset()
                self.blackjack.decks[2].reset()
                self.count = 0
            }
        }))
        self.presentViewController(alert, animated: true, completion: nil)
    }

}

