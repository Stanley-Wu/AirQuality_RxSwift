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

    var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        disposeBag = DisposeBag()
    }
    
    override func tearDown() {
        disposeBag = nil
        super.tearDown()
    }
    
    func testAPIManager_GetAirQuality() throws {
        let expectation = self.expectation(description: "Completion handler invoked")
        var responseDatas: [Any]?
        var responseError: Error?
        APIManager.getAirQuality()
            .subscribe(
                onSuccess: { [unowned self] (datas) in
                    responseDatas = datas
                    self.testAirQualityObj(aryDatas: datas)

                    expectation.fulfill()
                },
                onError: { (error) in
                    responseError = error
                    
                    expectation.fulfill()
            })
            .disposed(by: disposeBag)
        wait(for: [expectation], timeout: 5)
        XCTAssertNil(responseError)
        XCTAssertNotNil(responseDatas)
    }
    
    func testAPIManager_GetWeatherForecast() throws {
        let expectation = self.expectation(description: "Completion handler invoked")
        var responseDatas: [String: Any]?
        var responseError: Error?
        APIManager.getWeatherForecast()
            .subscribe(
                onSuccess: { [unowned self] (datas) in
                    responseDatas = datas
                    self.testWeatherForecastObj(dicWeather: datas)
                    
                    expectation.fulfill()
                },
                onError: { (error) in
                    responseError = error
                    
                    expectation.fulfill()
            })
            .disposed(by: disposeBag)
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
