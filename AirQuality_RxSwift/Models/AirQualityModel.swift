//
//  AirQualityModel.swift
//  AirQuality_RxSwift
//
//  Created by Dlink on 2020/8/21.
//  Copyright © 2020 Dlink. All rights reserved.
//

import Foundation

class AirQualityModel {}

// MARK: - Object
class AirQualityObj {
    var aqi: String = ""
    var co: String = ""
    var co_8hr: String = ""
    var country: String = ""
    var countryId: Int = -1
    var no: String = ""
    var no2: String = ""
    var nox: String = ""
    var o3: String = ""
    var o3_8hr: String = ""
    var pm10: String = ""
    var pm10_avg: String = ""
    var pm2_5: String = ""
    var pm2_5_avg: String = ""
    var pollutant: String = ""
    var publishTime: String = ""
    var so2: String = ""
    var siteName: String = ""
    var status: String = ""
    var windDirec: String = ""
    var windSpeed: String = ""
    
    init(dicData: [String: Any]) {
        self.aqi = dicData["AQI"] as? String ?? ""
        self.co = dicData["CO"] as? String ?? ""
        self.co_8hr = dicData["CO_8hr"] as? String ?? ""
        self.country = dicData["County"] as? String ?? ""
        self.no = dicData["NO"] as? String ?? ""
        self.no2 = dicData["NO2"] as? String ?? ""
        self.nox = dicData["NOx"] as? String ?? ""
        self.o3 = dicData["O3"] as? String ?? ""
        self.o3_8hr = dicData["O3_8hr"] as? String ?? ""
        self.pm10 = dicData["PM10"] as? String ?? ""
        self.pm10_avg = dicData["PM10_AVG"] as? String ?? ""
        self.pm2_5 = dicData["PM2.5"] as? String ?? ""
        self.pm2_5_avg = dicData["PM2.5_AVG"] as? String ?? ""
        self.pollutant = dicData["Pollutant"] as? String ?? ""
        self.publishTime = dicData["PublishTime"] as? String ?? ""
        self.so2 = dicData["SO2"] as? String ?? ""
        self.siteName = dicData["SiteName"] as? String ?? ""
        self.status = dicData["Status"] as? String ?? ""
        self.windDirec = dicData["WindDirec"] as? String ?? ""
        self.windSpeed = dicData["WindSpeed"] as? String ?? ""
    }
}
