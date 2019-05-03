//
//  CropViewController.swift
//  MMH
//
//  Created by Houston Krohman on 2016-07-05.
//  Copyright © 2016 Houston Krohman. All rights reserved.
//

import UIKit

class CropViewController: UIViewController {

    @IBOutlet weak var datePlantedLabel: UILabel!
    @IBOutlet weak var weekNumLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    let defaults = NSUserDefaults.standardUserDefaults()
    let calendar = NSCalendar.currentCalendar()
    let dateFormatter = NSDateFormatter()


    var startDate: NSDate!
    var todaysDate: NSDate!
    var weekNum: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        todaysDate = NSDate()
       
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if let datePlanted = defaults.objectForKey("datePlanted") as? NSDate{
            startDate = datePlanted
            upDateWeekNumber()
            updateLabels()

            datePicker.setValue(UIColor.whiteColor(), forKeyPath: "textColor")
            datePicker.setValue(0.8, forKeyPath: "alpha")
            
        }
        else{
            displayAlert()
        }
    }
    

    func checkValidDate(){
        let order = todaysDate.compare(startDate)
        
        let dayCalendarUnit: NSCalendarUnit = [.Day]
        let dateDiff = calendar.components(
            dayCalendarUnit,
            fromDate: startDate,
            toDate: todaysDate,
            options: [])
       
        let dayNum = dateDiff.day
        
        //If date is invalid
        if (order == .OrderedAscending || dayNum >= 63) {
            startDate = NSDate()
            let alertController = UIAlertController(title: "Invalid Start Date", message:
                "Please choose a date within the past 9 weeks", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Use today as the date planted", style: UIAlertActionStyle.Default,handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        defaults.setObject(startDate, forKey: "datePlanted")
    }
    
    func displayAlert(){
        let alertController = UIAlertController(title: "Start a New Crop", message:
            "You need a start date to use the app. ", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Use today as the date planted", style: UIAlertActionStyle.Default,handler: nil))
        
        self.presentViewController(alertController, animated: true, completion: nil)
        startDate = NSDate()
        defaults.setObject(startDate, forKey: "datePlanted")

    }

    @IBAction func setPlantedDate(sender: UIButton) {
        self.startDate = datePicker.date
        checkValidDate()
        updateLabels()
        defaults.setObject(startDate, forKey: "datePlanted")
        defaults.setInteger(0, forKey: "numWaters")
        defaults.setObject(nil, forKey: "lastWaterDate")

    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func resetStartDate(sender: AnyObject) {
        startDate = NSDate()
        defaults.setObject(startDate, forKey: "datePlanted")
        defaults.setInteger(0, forKey: "numWaters")
        defaults.setObject(nil, forKey: "lastWaterDate")
        updateLabels()
    }
    
    func updateLabels(){
        upDateWeekNumber()
        weekNumLabel.text = String(weekNum)
    
        dateFormatter.dateStyle = NSDateFormatterStyle.LongStyle
        let plantedStr = dateFormatter.stringFromDate(startDate)
        datePlantedLabel.text = plantedStr
    }
    
    func upDateWeekNumber(){
        let daysUnit: NSCalendarUnit = [.Day]
        
        let timeSincePlanted = calendar.components(daysUnit, fromDate: startDate, toDate: todaysDate,
                                                   options: [])
        let numDays: Double = Double(timeSincePlanted.day)
        let numberWeeks: Double = (numDays / 7.0)
        
        if(numDays == 0){
            weekNum = 1
        } else{
            weekNum = Int(ceil(numberWeeks))
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
