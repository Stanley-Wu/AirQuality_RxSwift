//
//  TimeUtility.swift
//  AppDesignPattern
//
//  Created by Dlink on 2018/2/6.
//  Copyright © 2018年 Stanley. All rights reserved.
//

import Foundation

class TimeUtility {
    static func stringConvertToDateWithDateFormatter(formatter: String, string: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatter
        return dateFormatter.date(from: string)
    }
    
    static func dateConvertToStringWithDateFormatter(formatter: String, timeInterval: TimeInterval) -> String? {
        let dateFormatter = DateFormatter()
        let currentDate = Date(timeIntervalSince1970: timeInterval)
        
        dateFormatter.dateFormat = formatter
        return dateFormatter.string(from: currentDate)
    }
    
}
