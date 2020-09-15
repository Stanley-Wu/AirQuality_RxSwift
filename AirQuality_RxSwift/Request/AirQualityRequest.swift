//
//  AirQualityRequest.swift
//  AirQuality_RxSwift
//
//  Created by Stanley on 2020/8/20.
//  Copyright © 2020 Stanley. All rights reserved.
//

import Foundation
import RxSwift

class AirQualityRequest {
    static func getAirQualityDataRequest() -> Single<[Any]> {
        return Single<[Any]>.create { (single) -> Disposable in
            // API from OpenData : https://data.gov.tw/dataset/40448
            let request = NSMutableURLRequest(url: URL(string: "http://opendata2.epa.gov.tw/AQI.json")!,
                                              cachePolicy: .useProtocolCachePolicy,
                                              timeoutInterval: 60)
            request.httpMethod = "GET"
            
            let session = URLSession.shared
            let task = session.dataTask(with: request as URLRequest) {data, _, error in
                do {
                    if let error = error {
                        single(.error(error))
                        return
                    }
                    
                    if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: []) as? [Any] {
                        print("AirQualityRequest Response : \(jsonResult)")
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
