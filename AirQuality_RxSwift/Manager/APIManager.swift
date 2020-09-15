//
//  APIManager.swift
//  AirQuality_RxSwift
//
//  Created by Stanley on 2020/8/20.
//  Copyright © 2020 Stanley. All rights reserved.
//

import Foundation

class APIManager {
    static func getAirQuality(completion: @escaping ([Any]?, Error?) -> Void) {
        AirQualityRequest.init().getAirQualityDataRequest { (data, failure) in
            if let error = failure {
                completion(nil, error)
            }
            else {
                completion(data!, nil)
            }
        }
    }
    
    static func getWeatherForecast(completion: @escaping ([String: Any]?, Error?) -> Void) {
        WeatherForecastRequest.init().getWeatherForecastDataRequest { (data, failure) in
            if let error = failure {
                completion(nil, error)
            }
            else {
                completion(data!, nil)
            }
        }
    }
}
