//
//  ViewController.swift
//  Blackjack
//
//  Created by Kong Huang on 9/21/14.
//  Copyright (c) 2014 Kong Huang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var DealerCard1: UIImageView!
    @IBOutlet var DealerCard2: UIImageView!
    @IBOutlet var DealerCard3: UIImageView!
    @IBOutlet var DealerCard4: UIImageView!
    @IBOutlet var DealerCard5: UIImageView!
    @IBOutlet var DealerCard6: UIImageView!
    @IBOutlet var DealerLabel: UILabel!
    
    var dealerCount = 2
    var dealerBust = false

    @IBOutlet var AICard1: UIImageView!
    @IBOutlet var AICard2: UIImageView!
    @IBOutlet var AICard3: UIImageView!
    @IBOutlet var AICard4: UIImageView!
    @IBOutlet var AICard5: UIImageView!
    @IBOutlet var AICard6: UIImageView!
    @IBOutlet var AILabel: UILabel!
    
    var AICount = 2
    var AIBust = false
    var AIBeatDealer = true
    
    @IBOutlet var Player1Card1: UIImageView!
    @IBOutlet var Player1Card2: UIImageView!
    @IBOutlet var Player1Card3: UIImageView!
    @IBOutlet var Player1Card4: UIImageView!
    @IBOutlet var Player1Card5: UIImageView!
    @IBOutlet var Player1Card6: UIImageView!
    
    @IBOutlet var Player1Score: UILabel!
    @IBOutlet var Player1Name: UILabel!
    @IBOutlet var Player1State: UILabel!
    
    var Player1Count = 2
    var Player1Done = false
    var Player1Bust = false
    var Player1BeatDealer = true
    
    @IBOutlet var Player2Card1: UIImageView!
    @IBOutlet var Player2Card2: UIImageView!
    @IBOutlet var Player2Card3: UIImageView!
    @IBOutlet var Player2Card4: UIImageView!
    @IBOutlet var Player2Card5: UIImageView!
    @IBOutlet var Player2Card6: UIImageView!
    
    @IBOutlet var Player2Score: UILabel!
    @IBOutlet var Player2Name: UILabel!
    @IBOutlet var Player2State: UILabel!
    
    var Player2Count = 2
    var Player2Done = false
    var Player2Bust = false
    var Player2BeatDealer = true
    
    var Blackjack:BlackjackModel = BlackjackModel()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        Blackjack.setup()
        
        var image = UIImage(named: Blackjack.dealer.cards[0].fileName())
        DealerCard1.image = image
        image = UIImage(named: Blackjack.dealer.cards[1].fileName())
        DealerCard2.image = image
        
        image = UIImage(named: Blackjack.players[0].playerHand.cards[0].fileName())
        AICard1.image = image
        image = UIImage(named: Blackjack.players[0].playerHand.cards[1].fileName())
        AICard2.image = image

        image = UIImage(named: Blackjack.players[1].playerHand.cards[0].fileName())
        Player1Card1.image = image
        image = UIImage(named: Blackjack.players[1].playerHand.cards[1].fileName())
        Player1Card2.image = image

        image = UIImage(named: Blackjack.players[2].playerHand.cards[0].fileName())
        Player2Card1.image = image
        image = UIImage(named: Blackjack.players[2].playerHand.cards[1].fileName())
        Player2Card2.image = image
        
        Player1State.text = ""
        Player2State.text = ""
        
        Blackjack.players[0].playerPocket -= Blackjack.players[0].playerBet
        Blackjack.players[1].playerPocket -= Blackjack.players[1].playerBet
        Blackjack.players[2].playerPocket -= Blackjack.players[2].playerBet
        
        Player1Score.text = "$" + String(Blackjack.players[1].playerPocket)
        Player2Score.text = "$" + String(Blackjack.players[2].playerPocket)
        
        DealerLabel.text = "Dealer (" + String(Blackjack.dealer.getPipValue()) + ")"
        AILabel.text = "AI Player (" + String(Blackjack.players[0].playerHand.getPipValue()) + ")"
        Player1Name.text = Blackjack.players[1].playerName + " (" + String(Blackjack.players[1].playerHand.getPipValue()) + ")"
        Player2Name.text = Blackjack.players[2].playerName + " (" + String(Blackjack.players[2].playerHand.getPipValue()) + ")"
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func EndTurn(sender: AnyObject) {
        dealerAndAI()
    }
    
    func dealerAndAI(){
        
        while (Blackjack.players[0].playerHand.getPipValue() < 19){
            println("TestingA:..." + String(Blackjack.players[0].playerHand.getPipValue()))
            AICount = AICount + 1
            Blackjack.players[0].playerHand.addCard(Blackjack.shoe.drawCard())
            var image = UIImage(named: Blackjack.players[0].playerHand.cards[0].fileName())
            
            switch(AICount){
            case 3:
                AICard3.image = image
                break
            case 4:
                AICard4.image = image
                break
            case 5:
                AICard5.image = image
                break
            default:
                break
            }
        }
        if (Blackjack.players[0].playerHand.getPipValue() > 21){
            AIBust = true
        }
        
        Blackjack.dealer.cards[0].cardClose = false
        var image = UIImage(named: Blackjack.dealer.cards[0].fileName())
        DealerCard1.image = image
        
        while (Blackjack.dealer.getPipValue() < 17){
            dealerCount = dealerCount + 1
            Blackjack.dealer.addCard(Blackjack.shoe.drawCard())
            image = UIImage(named: Blackjack.dealer.cards[0].fileName())
            
            switch(dealerCount){
            case 3:
                DealerCard3.image = image
                break
            case 4:
                DealerCard4.image = image
                break
            case 5:
                DealerCard5.image = image
                break
            default:
                break
            }
        }
        
        if (Blackjack.dealer.getPipValue() > 21){
            dealerBust = true
        }
        if (Blackjack.dealer.getPipValue() > Blackjack.players[0].playerHand.getPipValue()){
            AIBeatDealer = false
        }
        if (Blackjack.dealer.getPipValue() > Blackjack.players[1].playerHand.getPipValue()){
            Player1BeatDealer = false
        }
        if (Blackjack.dealer.getPipValue() > Blackjack.players[2].playerHand.getPipValue()){
            Player2BeatDealer = false
        }
        
        DealerLabel.text = "Dealer (" + String(Blackjack.dealer.getPipValue()) + ")"
        AILabel.text = "AI Player (" + String(Blackjack.players[0].playerHand.getPipValue()) + ")"
        
        popUpBox()
    }
    
    @IBAction func Player1Hit(sender: AnyObject) {
        if (!Player1Done){
            Player1Count = Player1Count + 1
            Blackjack.players[1].playerHand.addCard(Blackjack.shoe.drawCard())
            var image = UIImage(named: Blackjack.players[1].playerHand.cards[0].fileName())
            
            switch(Player1Count){
            case 3:
                Player1Card3.image = image
                break
            case 4:
                Player1Card4.image = image
                break
            case 5:
                Player1Card5.image = image
                break
            default:
                break
            }
            
            Player1Name.text = Blackjack.players[1].playerName + " (" + String(Blackjack.players[1].playerHand.getPipValue()) + ")"
            
            if (Blackjack.players[1].playerHand.getPipValue() > 21){
                Player1State.text = "Bust!!"
                Player1Done = true
                Player1Bust = true
            } else if (Blackjack.players[1].playerHand.getPipValue() == 21){
                Player1State.text = "Blackjack!!"
                Player1Done = true
            }
        }
        if (Player1Done && Player2Done){
            dealerAndAI()
        }
    }
    
    @IBAction func Player1Stand(sender: AnyObject) {
        if (Blackjack.players[1].playerHand.getPipValue() == 21){
            Player1State.text = "Blackjack!!"
            Player1Done = true
        }
        else {
            Player1Done = true
        }
        
        if (Player1Done && Player2Done){
            dealerAndAI()
        }
    
    }

    @IBAction func Player2Hit(sender: AnyObject) {
        if (!Player2Done){
            Player2Count = Player2Count + 1
            Blackjack.players[2].playerHand.addCard(Blackjack.shoe.drawCard())
            var image = UIImage(named: Blackjack.players[2].playerHand.cards[0].fileName())
            
            switch(Player2Count){
            case 3:
                Player2Card3.image = image
                break
            case 4:
                Player2Card4.image = image
                break
            case 5:
                Player2Card5.image = image
                break
            default:
                break
            }
            
            Player2Name.text = Blackjack.players[2].playerName + " (" + String(Blackjack.players[2].playerHand.getPipValue()) + ")"
            
            if (Blackjack.players[2].playerHand.getPipValue() > 21){
                Player2State.text = "Bust!!"
                Player2Done = true
                Player2Bust = true
            } else if (Blackjack.players[2].playerHand.getPipValue() == 21){
                Player2State.text = "Blackjack!!"
                Player2Done = true
            }
        }
        if (Player1Done && Player2Done){
            dealerAndAI()
        }
    }
    
    
    @IBAction func Player2Stand(sender: AnyObject) {
        if (Blackjack.players[2].playerHand.getPipValue() == 21){
            Player2State.text = "Blackjack!!"
            Player2Done = true
        }
        else {
            Player2Done = true
        }
        
        if (Player1Done && Player2Done){
            dealerAndAI()
        }
    }
    
    func clean(){
        var image = UIImage(named: Blackjack.dealer.cards[0].fileName())
        DealerCard1.image = image
        image = UIImage(named: Blackjack.dealer.cards[1].fileName())
        DealerCard2.image = image
        
        image = UIImage(named: Blackjack.players[0].playerHand.cards[0].fileName())
        AICard1.image = image
        image = UIImage(named: Blackjack.players[0].playerHand.cards[1].fileName())
        AICard2.image = image
        
        image = UIImage(named: Blackjack.players[1].playerHand.cards[0].fileName())
        Player1Card1.image = image
        image = UIImage(named: Blackjack.players[1].playerHand.cards[1].fileName())
        Player1Card2.image = image
        
        image = UIImage(named: Blackjack.players[2].playerHand.cards[0].fileName())
        Player2Card1.image = image
        image = UIImage(named: Blackjack.players[2].playerHand.cards[1].fileName())
        Player2Card2.image = image
        
        Player1State.text = ""
        Player2State.text = ""
        
        DealerLabel.text = "Dealer (" + String(Blackjack.dealer.getPipValue()) + ")"
        AILabel.text = "AI Player (" + String(Blackjack.players[0].playerHand.getPipValue()) + ")"
        Player1Name.text = Blackjack.players[1].playerName + " (" + String(Blackjack.players[1].playerHand.getPipValue()) + ")"
        Player2Name.text = Blackjack.players[2].playerName + " (" + String(Blackjack.players[2].playerHand.getPipValue()) + ")"
        
        DealerCard3.image = nil
        DealerCard4.image = nil
        DealerCard5.image = nil
        
        AICard3.image = nil
        AICard4.image = nil
        AICard5.image = nil
        
        Player1Card3.image = nil
        Player1Card4.image = nil
        Player1Card5.image = nil
        
        Player2Card3.image = nil
        Player2Card4.image = nil
        Player2Card5.image = nil
        
        dealerCount = 2
        dealerBust = false
        
        AICount = 2
        AIBust = false
        AIBeatDealer = true
        Blackjack.players[0].playerPocket -= Blackjack.players[0].playerBet
        
        Player1Count = 2
        Player1Done = false
        Player1Bust = false
        Player1BeatDealer = true
        Blackjack.players[1].playerPocket -= Blackjack.players[1].playerBet
        
        Player2Count = 2
        Player2Done = false
        Player2Bust = false
        Player2BeatDealer = true
        Blackjack.players[2].playerPocket -= Blackjack.players[2].playerBet
        
        Player1Score.text = "$" + String(Blackjack.players[1].playerPocket)
        Player2Score.text = "$" + String(Blackjack.players[2].playerPocket)
        
    }
    
    func popUpBox(){
        var titles = "Round over"
        var messages = ""
        
        if (dealerBust){
            if (!AIBust){
                Blackjack.players[0].playerPocket += Blackjack.players[0].playerBet * 2
            }
            if (!Player1Bust){
                Blackjack.players[1].playerPocket += Blackjack.players[1].playerBet * 2
            }
            if (!Player2Bust){
                Blackjack.players[2].playerPocket += Blackjack.players[2].playerBet * 2
            }
        }
        else{
            if (AIBeatDealer){
                Blackjack.players[0].playerPocket += Blackjack.players[0].playerBet * 2
            }
            if (Player1BeatDealer){
                Blackjack.players[1].playerPocket += Blackjack.players[1].playerBet * 2
            }
            if (Player2BeatDealer){
                Blackjack.players[2].playerPocket += Blackjack.players[2].playerBet * 2
            }
        }
        
        var alert = UIAlertController(title: titles, message: messages, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Click for next round", style: UIAlertActionStyle.Default, handler: {(action)
            -> Void in
            self.Blackjack.newRound()
            self.clean()

        }))
        self.presentViewController(alert, animated: true, completion: nil)
    }

}

