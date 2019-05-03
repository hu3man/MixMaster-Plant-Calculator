//
//  NutrientCalcViewController.swift
//  MMH
//
//  Created by Houston Krohman on 2016-07-04.
//  Copyright © 2016 Houston Krohman. All rights reserved.
//

import UIKit


class NutrientCalcViewController: UIViewController, UITextFieldDelegate {

    var resSize: Int = 0
    var weekNumber: Int!
    var todaysDate: NSDate!
    var datePlanted: NSDate!
    
    let defaults = NSUserDefaults.standardUserDefaults()
    let calendar = NSCalendar.currentCalendar()
    
    @IBOutlet weak var feedDate: UIDatePicker!
    @IBOutlet weak var galsOfWater: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var weekNum: UILabel!
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        galsOfWater.delegate = self
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        datePlanted = defaults.objectForKey("datePlanted") as? NSDate
        todaysDate = NSDate()
        upDateWeekNumber()
        weekNum.text = String(weekNumber)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func updateResSize(){
                if let gals = galsOfWater.text{
                    if let galInt = Int(gals){
                        resSize = galInt
                    }
                    else{
                        resSize = 0
                    }
                }
                else{
                    resSize = 0
                }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func upDateWeekNumber(){
            let daysUnit: NSCalendarUnit = [.Day]
        
        let timeSincePlanted = calendar.components(daysUnit, fromDate: datePlanted, toDate: todaysDate,
                                                      options: [])
            let numDays: Double = Double(timeSincePlanted.day)
            let numberWeeks: Double = (numDays / 7.0)
            
            if(numDays == 0){
                weekNumber = 1
            } else{
                weekNumber = Int(ceil(numberWeeks))
        }
    }
    
    @IBAction func startWalkthrough(sender: UIButton) {

        updateResSize()
        
         //Show error popup if incorrect data entered
        if (resSize <= 0 || resSize > 1000) {
            let alertController = UIAlertController(title: "Missing info", message:
                "Please enter the number of gallons of fresh water in your reservoir (1-1000)", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        else if(weekNumber > 9){
            let alertController = UIAlertController(title: "Invalid date", message:
                "Your crop should be finished by now. Please start a new crop of adjust the start date", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)

        }
        else {
            performSegueWithIdentifier("nutrientGuideSegue", sender: self)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "nutrientGuideSegue"{
            if let destinationVC = segue.destinationViewController as? FeedViewController{
                destinationVC.reservoirSize = resSize
                destinationVC.weekNumber = weekNumber
                
                var numWaters = defaults.integerForKey("numWaters")
                numWaters += 1
                defaults.setInteger(numWaters, forKey: "numWaters")
                defaults.setObject(todaysDate, forKey: "lastWaterDate")
            }
        }
    }
}
    


