//
//  AirQuality_RxSwiftTests.swift
//  AirQuality_RxSwiftTests
//
//  Created by Stanley on 2020/9/8.
//  Copyright © 2020 Stanley. All rights reserved.
//

import XCTest
@testable import AirQuality_RxSwift
@testable import RxSwift

class AirQualityRxSwiftTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testAPIManager_GetAirQuality() throws {
        let expectation = self.expectation(description: "Completion handler invoked")
        var responseDatas: [Any]?
        var responseError: Error?
        APIManager.getAirQuality { [unowned self] (datas, error) in
            responseDatas = datas
            responseError = error
            
            self.testAirQualityObj(aryDatas: datas)
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
        XCTAssertNil(responseError)
        XCTAssertNotNil(responseDatas)
    }
    
    func testAPIManager_GetWeatherForecast() throws {
        let expectation = self.expectation(description: "Completion handler invoked")
        var responseDatas: [String: Any]?
        var responseError: Error?
        APIManager.getWeatherForecast { [unowned self] (datas, error) in
            responseDatas = datas
            responseError = error
            
            self.testWeatherForecastObj(dicWeather: datas)
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
        XCTAssertNil(responseError)
        XCTAssertNotNil(responseDatas)
    }
    
    func testAirQualityObj(aryDatas: [Any]?) {
        XCTAssertNotNil(aryDatas)
        
        for result in aryDatas! {
            if let dic = result as? [String: Any] {
                let obj = AirQualityObj(dicData: dic)
                XCTAssertNotEqual(obj.siteName, "")
            }
        }
    }
    
    func testWeatherForecastObj(dicWeather: [String: Any]?) {
        XCTAssertNotNil(dicWeather)
        
        if let records = dicWeather!["records"] as? [String: Any] {
            if let locations = records["location"] as? [[String: Any]] {
                for location in locations {
                    let obj = WeatherForecastObj(dicData: location)
                    XCTAssertNotEqual(obj.locationName, "")
                }
            }
        }
    }

}
