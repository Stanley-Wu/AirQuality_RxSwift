//
//  WeatherForecastModel.swift
//  AirQuality_RxSwift
//
//  Created by Stanley on 2020/9/3.
//  Copyright © 2020 Stanley. All rights reserved.
//

import Foundation

class WeatherForecastModel {}

// MARK: - Object
class WeatherForecastObj {
    var locationId: Int = -1
    var locationName: String = ""
    var forecast: [ForecastObj] = [ForecastObj]()
    
    init(dicData: [String: Any]) {
        self.locationName = dicData["locationName"] as? String ?? ""
        let weatherElement = dicData["weatherElement"] as? [[String: Any]] ?? []
        
        var aryWx = [[String: String]]()
        var aryPoP = [[String: String]]()
        var aryMinT = [[String: String]]()
        var aryMaxT = [[String: String]]()
        var aryCI = [[String: String]]()
        
        for element in weatherElement {
            for time in element["time"] as! [[String: Any]] {
                if element["elementName"] as! String == "Wx" {
                    var dicWx = [String: String]()
                    let parameter = time["parameter"] as! [String: String]
                    
                    dicWx["startTime"] = time["startTime"] as? String
                    dicWx["endTime"] = time["endTime"] as? String
                    dicWx["parameterName"] = parameter["parameterName"]
                    aryWx.append(dicWx)
                }
                else if element["elementName"] as! String == "PoP" {
                    var dicPoP = [String: String]()
                    let parameter = time["parameter"] as! [String: String]
                    
                    dicPoP["startTime"] = time["startTime"] as? String
                    dicPoP["endTime"] = time["endTime"] as? String
                    dicPoP["parameterName"] = parameter["parameterName"]
                    aryPoP.append(dicPoP)
                }
                else if element["elementName"] as! String == "MinT" {
                    var dicMinT = [String: String]()
                    let parameter = time["parameter"] as! [String: String]
                    
                    dicMinT["startTime"] = time["startTime"] as? String
                    dicMinT["endTime"] = time["endTime"] as? String
                    dicMinT["parameterName"] = parameter["parameterName"]
                    aryMinT.append(dicMinT)
                }
                else if element["elementName"] as! String == "MaxT" {
                    var dicMaxT = [String: String]()
                    let parameter = time["parameter"] as! [String: String]
                    
                    dicMaxT["startTime"] = time["startTime"] as? String
                    dicMaxT["endTime"] = time["endTime"] as? String
                    dicMaxT["parameterName"] = parameter["parameterName"]
                    aryMaxT.append(dicMaxT)
                }
                else if element["elementName"] as! String == "CI" {
                    var dicCI = [String: String]()
                    let parameter = time["parameter"] as! [String: String]
                    
                    dicCI["startTime"] = time["startTime"] as? String
                    dicCI["endTime"] = time["endTime"] as? String
                    dicCI["parameterName"] = parameter["parameterName"]
                    aryCI.append(dicCI)
                }
            }
        }
        
        for dicWx in aryWx {
            let forecastModel = ForecastObj()
            forecastModel.startTime = dicWx["startTime"] ?? ""
            forecastModel.endTime = dicWx["endTime"] ?? ""
            forecastModel.nameWx = dicWx["parameterName"] ?? ""
            self.forecast.append(forecastModel)
        }
        
        for dicPoP in aryPoP {
            if let forecastModel = self.forecast.filter({ $0.startTime == dicPoP["startTime"]! }).first {
                forecastModel.namePoP = dicPoP["parameterName"] ?? ""
            }
        }
        
        for dicMinT in aryMinT {
            if let forecastModel = self.forecast.filter({ $0.startTime == dicMinT["startTime"]! }).first {
                forecastModel.nameMinT = dicMinT["parameterName"] ?? ""
            }
        }
        
        for dicMaxT in aryMaxT {
            if let forecastModel = self.forecast.filter({ $0.startTime == dicMaxT["startTime"]! }).first {
                forecastModel.nameMaxT = dicMaxT["parameterName"] ?? ""
            }
        }
        
        for dicCI in aryCI {
            if let forecastModel = self.forecast.filter({ $0.startTime == dicCI["startTime"]! }).first {
                forecastModel.nameCI = dicCI["parameterName"] ?? ""
            }
        }
    }
}

class ForecastObj {
    var startTime: String = ""
    var endTime: String = ""
    var nameWx: String = "" // 天氣狀況
    var namePoP: String = "" // 降雨機率
    var nameMinT: String = "" // 最低溫度
    var nameMaxT: String = "" // 最高溫度
    var nameCI: String = "" // 舒適度
    
    init() {
        
    }
}
