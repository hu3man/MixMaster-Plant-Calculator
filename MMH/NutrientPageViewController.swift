//
//  NutrientPageViewController.swift
//  MMH
//
//  Created by Houston Krohman on 2016-06-28.
//  Copyright © 2016 Houston Krohman. All rights reserved.
//

import UIKit

class NutrientPageViewController: UIViewController {

    @IBOutlet weak var nutrientImage: UIImageView!
    @IBOutlet weak var nutrientDose: UILabel!
    @IBOutlet weak var nutrientName: UILabel!
    @IBOutlet weak var pageNumber: UILabel!
    
    var itemIndex: Int!
    var currentNutrient: String!
    var numberItems: Int!
    var imageName: String!
    var feedSchedule: [Int]!
    var resSize: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.nutrientImage.image = UIImage(named: self.imageName)
        self.nutrientName.text = currentNutrient
        self.pageNumber.text = "Step " + String(itemIndex + 1) + "/" + String(numberItems)
        
        let dose = feedSchedule[itemIndex] * resSize
        self.nutrientDose.text = String(dose) + " mL"
        // Do any additional setup after loading the view.
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
