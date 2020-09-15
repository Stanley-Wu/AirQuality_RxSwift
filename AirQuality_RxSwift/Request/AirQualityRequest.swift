//
//  AirQualityRequest.swift
//  AirQuality_RxSwift
//
//  Created by Stanley on 2020/8/20.
//  Copyright © 2020 Stanley. All rights reserved.
//

import Foundation

class AirQualityRequest: NSObject {
    
    func getAirQualityDataRequest(completion: @escaping ([Any]?, Error?) -> Void) {
        // API from OpenData : https://data.gov.tw/dataset/40448
        let request = NSMutableURLRequest(url: URL(string: "http://opendata2.epa.gov.tw/AQI.json")!,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 60)
        request.httpMethod = "GET" // POST ,GET, PUT What you want
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest) {data, _, error in
            do {
                guard data != nil else {
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                    return
                }
                
                if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: []) as? [Any] {
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
