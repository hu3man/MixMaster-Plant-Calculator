//
//  FeedViewController.swift
//  MMH
//
//  Created by Houston Krohman on 2016-07-03.
//  Copyright © 2016 Houston Krohman. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController, UIPageViewControllerDataSource {

    var pageViewController: UIPageViewController!
    
    var reservoirSize: Int!
    var weekNumber: Int!
    
    var nutrientTitles: NSArray!
    var pageImages: NSArray!
    
    //Feed rates for each product per week (mL per gallon of water)
    let feedSchedule: [[Int]] = [
        [3, 2, 3, 2, 5, 2, 3],
        [5, 5, 5, 2, 8, 2, 4],
        [3, 5, 5, 3, 5, 3, 3],
        [2, 6, 5, 3, 7, 3, 4],
        [2, 7, 5, 4, 4, 3, 5],
        [3, 7, 6, 4, 0, 5, 5],
        [2, 8, 6, 5, 8, 3, 4],
        [1, 7, 5, 4, 3, 2, 3],
        [0, 6, 5, 3, 0, 2, 2]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.nutrientTitles = NSArray(objects: "GP3 Grow", "GP3 Bloom", "GP3 Micro", "Pro-Cal", "Root Builder", "GPF Uptake", "GPH Uptake" )
        self.pageImages = NSArray(objects: "gp3grow", "gp3bloom", "gp3micro", "procal", "rootbuilder", "gpfuptake", "gphuptake")
        
        
        self.pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PageViewController") as! UIPageViewController
        self.pageViewController.dataSource = self
        
        let newVc = self.viewControllerAtIndex(0) as NutrientPageViewController
        let viewControllers = NSArray(object: newVc)
        
        self.pageViewController.setViewControllers(viewControllers as? [UIViewController], direction: .Forward, animated: true, completion: nil)
        
        self.pageViewController.view.frame = CGRectMake(0, 30, self.view.frame.width, self.view.frame.height)
        self.addChildViewController(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        self.pageViewController.didMoveToParentViewController(self)
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func viewControllerAtIndex(index: Int) -> NutrientPageViewController
    {
        if(self.nutrientTitles.count == 0 || (index >= self.nutrientTitles.count)) {
            return NutrientPageViewController()
        }
        let vc: NutrientPageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("NutrientPageContent") as! NutrientPageViewController

        vc.currentNutrient = nutrientTitles[index] as! String
        vc.imageName = pageImages[index] as! String
        vc.itemIndex = index
        vc.numberItems = self.nutrientTitles.count
        vc.resSize = reservoirSize
        vc.feedSchedule = self.feedSchedule[weekNumber - 1]
        return vc
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        let vc = viewController as! NutrientPageViewController
        var index = vc.itemIndex as Int
        
        if(index == 0 || index == NSNotFound){
            return nil
        }
        
        index -= 1
        return self.viewControllerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        let vc = viewController as! NutrientPageViewController
        var index = vc.itemIndex as Int
        
        if(index == NSNotFound){
            return nil
        }
        
        
        index += 1
        
        if(index == self.nutrientTitles.count){
            return nil
        }
        return self.viewControllerAtIndex(index)
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return self.nutrientTitles.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
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
