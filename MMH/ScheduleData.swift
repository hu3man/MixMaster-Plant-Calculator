//
//  ScheduleData.swift
//  MMH
//
//  Created by Houston Krohman on 2016-07-03.
//  Copyright © 2016 Houston Krohman. All rights reserved.
//

import UIKit

class ScheduleData: NSObject {

    let feedSchedule: [[Int]] = [
                                    [5, 5, 5, 2, 8, 2, 4],
                                    [3, 5, 5, 3, 5, 3, 3],
                                    [2, 6, 5, 3, 7, 3, 4],
                                    [2, 7, 5, 4, 4, 3, 5],
                                    [3, 7, 6, 4, 0, 5, 5],
                                    [2, 8, 6, 5, 8, 3, 4],
                                    [1, 7, 5, 4, 3, 2, 3],
                                    [0, 6, 5, 3, 0, 2, 2]
                                    ]
    
    func getDosage(week: Int, nutrientIndex: Int, reservoirSizeInGal: Int) -> Int{
        let dosage = feedSchedule[week - 1][nutrientIndex] * reservoirSizeInGal
        return dosage
    }
}
