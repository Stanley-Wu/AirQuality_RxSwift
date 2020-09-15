//
//  WeatherForecastRequest.swift
//  AirQuality
//
//  Created by Stanley on 2018/3/2.
//  Copyright © 2018年 Stanley. All rights reserved.
//

import Foundation
import RxSwift

class WeatherForecastRequest {
    static func getWeatherForecastDataRequest() -> Single<[String: Any]> {
        return Single<[String: Any]>.create { (single) -> Disposable in
            // API from OpenData: https://data.gov.tw/dataset/6069
            let strUrl = "https://opendata.cwb.gov.tw/api/v1/rest/datastore/F-C0032-001?Authorization=rdec-key-123-45678-011121314"
            let request = NSMutableURLRequest(url: URL(string: strUrl)!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60)
            request.httpMethod = "GET" // POST ,GET, PUT What you want
            
            let session = URLSession.shared
            let task = session.dataTask(with: request as URLRequest) {data, _, error in
                do {
                    if let error = error {
                        single(.error(error))
                        return
                    }
                    
                    if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
                        print("WeatherForecastRequest Response : \(jsonResult)")
                        single(.success(jsonResult))
                    }
                } catch {
                    print(error.localizedDescription)
                    single(.error(error))
                }
                
            }
            task.resume()

            return Disposables.create { task.cancel() }
        }
    }
}
