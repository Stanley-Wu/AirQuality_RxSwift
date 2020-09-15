//
//  APIManager.swift
//  AirQuality_RxSwift
//
//  Created by Stanley on 2020/8/20.
//  Copyright © 2020 Stanley. All rights reserved.
//

import Foundation
import RxSwift

class APIManager {
    static func getAirQuality() -> Single<[Any]> {
        return AirQualityRequest.getAirQualityDataRequest()
    }
    
    static func getWeatherForecast() -> Single<[String: Any]> {
        return WeatherForecastRequest.getWeatherForecastDataRequest()
    }
}
