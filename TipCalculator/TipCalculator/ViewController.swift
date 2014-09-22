//
//  ViewController.swift
//  TipCalculator
//
//  Created by Main Account on 7/7/14.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var totalTextField : UITextField!
    @IBOutlet var taxPctSlider : UISlider!
    @IBOutlet var taxPctLabel : UILabel!
    @IBOutlet var resultsTextView : UITextView!

    let tipCalc = TipCalculatorModel(total: 33.25, taxPct: 0.06)
    
    func refreshUI(){
        // 1
        totalTextField.text = String(format: "%0.2f", tipCalc.total)
        // 2
        taxPctSlider.value = Float(tipCalc.taxPct) * 100.0
        // 3
        taxPctLabel.text = "Tax Percentage (\(Int(taxPctSlider.value))%)"
        // 4
        resultsTextView.text = ""
    }
    
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    refreshUI()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
    @IBAction func calculateTapped(sender : AnyObject){
        // here you need to convert a string to a double
        tipCalc.total = Double((totalTextField.text as NSString).doubleValue)
        // here you call teh returnPossibleTips method on tipCalc model
        // returns a dictionary of possible tip percentages mapped to tip values
        let possibleTips = tipCalc.returnPossibleTips()
        var results = ""
        // this is how you enumerate through both keys and values of a dictionary at the same time in swift
        for (tipPct, tipValue) in possibleTips{
            // here you use string interpolation to build up the string to put in the results text file
            // \n is new line
            results += "\(tipPct)%: \(tipValue)\n"
        }
        // finally set the results text to the built string
        resultsTextView.text = results
    }

    @IBAction func taxPercentageChanged(sender : AnyObject){
        tipCalc.taxPct = Double(taxPctSlider.value) / 100.0
        refreshUI()
    }
    
    @IBAction func viewTapped(sender : AnyObject){
        totalTextField.resignFirstResponder()
    }

}
