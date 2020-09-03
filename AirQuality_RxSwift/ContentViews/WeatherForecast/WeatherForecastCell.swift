//
//  WeatherForecastCell.swift
//  AirQuality
//
//  Created by Dlink on 2018/3/2.
//  Copyright © 2018年 Stanley. All rights reserved.
//

import UIKit

class WeatherForecastCell: IndentionCell {
    @IBOutlet weak var lbStartTime: UILabel!
    @IBOutlet weak var lbEndTime: UILabel!
    @IBOutlet weak var lbConfort: UILabel!
    @IBOutlet weak var lbMaxT: UILabel!
    @IBOutlet weak var lbMinT: UILabel!
    @IBOutlet weak var lbPoP: UILabel!
    
    var forecastObj: ForecastObj = ForecastObj() {
        willSet {
            lbStartTime.text = self.convertTimeStringToUI(strTime: newValue.startTime) + " ～"
            lbEndTime.text = self.convertTimeStringToUI(strTime: newValue.endTime)
            lbConfort.text = newValue.nameCI
            lbMaxT.text = newValue.nameMaxT + " C"
            lbMinT.text = newValue.nameMinT + " C"
            lbPoP.text = newValue.namePoP + " %"
            configWeatherForecastCellLabelColor(forecast: newValue)
        }
    }
    
    //MARK: - private function
    private func convertTimeStringToUI(strTime: String) -> String {
        if let date = TimeUtility.stringConvertToDateWithDateFormatter(formatter: "yyyy-MM-dd HH:mm:ss", string: strTime) {
            return TimeUtility.dateConvertToStringWithDateFormatter(formatter: "MM-dd HH:mm", timeInterval: date.timeIntervalSince1970) ?? ""
        }
        else {
            return ""
        }
    }
    
    private func configWeatherForecastCellLabelColor(forecast: ForecastObj) {
        lbPoP.textColor = ColorManager.blue()
        
        if let maxT = Int(forecast.nameMaxT) {
            if maxT > 27 {
                lbMaxT.textColor = ColorManager.red()
            }
            else if maxT > 24 {
                lbMaxT.textColor = ColorManager.orange()
            }
            else if maxT > 17 {
                lbMaxT.textColor = ColorManager.green()
            }
            else {
                lbMaxT.textColor = ColorManager.blue()
            }
        }
        
        if let minT = Int(forecast.nameMinT) {
            if minT > 27 {
                lbMinT.textColor = ColorManager.red()
            }
            else if minT > 24 {
                lbMinT.textColor = ColorManager.orange()
            }
            else if minT > 17 {
                lbMinT.textColor = ColorManager.green()
            }
            else {
                lbMinT.textColor = ColorManager.blue()
            }
        }
    }
}
