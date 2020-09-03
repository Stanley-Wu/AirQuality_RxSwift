//
//  AirQualityCell.swift
//  AirQuality
//
//  Created by Dlink on 2018/3/1.
//  Copyright © 2018年 Stanley. All rights reserved.
//

import UIKit

class AirQualityCell: IndentionCell {
    @IBOutlet weak var lbCountry: UILabel!
    @IBOutlet weak var lbSite: UILabel!
    @IBOutlet weak var lbPollutant: UILabel!
    @IBOutlet weak var lbPM2_5: UILabel!
    @IBOutlet weak var lbPM2_5_AVG: UILabel!
    @IBOutlet weak var lbStatus: UILabel!
    
    var airQualityObj: AirQualityObj = AirQualityObj(dicData: [:]) {
        willSet {
            lbCountry.text = newValue.country
            lbSite.text = newValue.siteName
            lbPollutant.text = newValue.pollutant == "" ? "無資料" : newValue.pollutant
            lbPM2_5.text = newValue.pm2_5 == "" ? "0" : newValue.pm2_5
            lbPM2_5_AVG.text = newValue.pm2_5_avg == "" ? "0" : newValue.pm2_5_avg
            lbStatus.text = newValue.status
            configStatusLabelTextColor(statusLabel: lbStatus, aqi: newValue.aqi)
        }
    }
    
    //MARK: - private function
    private func configStatusLabelTextColor(statusLabel: UILabel, aqi: String) {
        if let intAqi = Int(aqi) {
            if intAqi < 50 {
                statusLabel.textColor = ColorManager.green()
            }
            else if intAqi < 100 {
                statusLabel.textColor = ColorManager.yellow()
            }
            else if intAqi < 150 {
                statusLabel.textColor = ColorManager.orange()
            }
            else if intAqi < 200 {
                statusLabel.textColor = ColorManager.red()
            }
            else if intAqi < 300 {
                statusLabel.textColor = ColorManager.purple()
            }
            else {
                statusLabel.textColor = ColorManager.brown()
            }
        }
        else {
            statusLabel.textColor = UIColor.black
        }
    }
}
