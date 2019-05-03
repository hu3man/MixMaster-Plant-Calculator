//
//  CropInfoViewController.swift
//  MMH
//
//  Created by Houston Krohman on 2016-07-05.
//  Copyright © 2016 Houston Krohman. All rights reserved.
//

import UIKit

class CropInfoViewController: UIViewController {

    @IBOutlet weak var averageDaysLabel: UILabel!
    @IBOutlet weak var numWatersLabel: UILabel!
    @IBOutlet weak var lastWaterLabel: UILabel!
    
    let defaults = NSUserDefaults.standardUserDefaults()
    let calendar = NSCalendar.currentCalendar()
    let dateFormatter = NSDateFormatter()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        let numWaters = defaults.integerForKey("numWaters")
        numWatersLabel.text = String(numWaters)
        
        let lastWater = defaults.objectForKey("lastWaterDate") as? NSDate
        if lastWater == nil{
            lastWaterLabel.text = "Never"
        }
        else{
            dateFormatter.dateStyle = NSDateFormatterStyle.LongStyle
            let dateStr = dateFormatter.stringFromDate(lastWater!)
            lastWaterLabel.text = dateStr
        }
        
        if numWaters != 0 {
            var average: Double
            
            let datePlanted = defaults.objectForKey("datePlanted") as? NSDate
            let todaysDate = NSDate()
            let daysUnit: NSCalendarUnit = [.Day]
            
            let timeSincePlanted = calendar.components(daysUnit, fromDate: datePlanted!, toDate: todaysDate,
                                                       options: [])
            let numDays: Double = Double(timeSincePlanted.day)
            let waters = Double(numWaters)
            average = numDays / waters
            averageDaysLabel.text = String(average)
        }
        else{
            averageDaysLabel.text = "0"
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
