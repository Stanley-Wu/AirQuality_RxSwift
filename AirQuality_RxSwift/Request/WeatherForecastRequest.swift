//
//  WeatherForecastRequest.swift
//  AirQuality
//
//  Created by Dlink on 2018/3/2.
//  Copyright © 2018年 Stanley. All rights reserved.
//

import Foundation

class WeatherForecastRequest: NSObject {
    func getWeatherForecastDataRequest(completion: @escaping (Dictionary<String, Any>?, Error?) -> Void) {
        // API from OpenData: https://data.gov.tw/dataset/6069
        let request = NSMutableURLRequest(url: URL(string: "https://opendata.cwb.gov.tw/api/v1/rest/datastore/F-C0032-001?Authorization=rdec-key-123-45678-011121314")!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60)
        request.httpMethod = "GET" // POST ,GET, PUT What you want
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest) {data, response, error in
            do {
                guard data != nil else {
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                    return
                }
                
                if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: []) as? Dictionary<String, Any> {
                    print("AirQualityRequest Response : \(jsonResult)")
                    DispatchQueue.main.async {
                        completion(jsonResult, nil)
                    }
                }
            } catch {
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
            
        }
        dataTask.resume()
    }
}
