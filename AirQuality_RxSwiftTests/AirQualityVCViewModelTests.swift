//
//  AirQualityVCViewModelTests.swift
//  AirQuality_RxSwiftTests
//
//  Created by Stanley on 2020/9/8.
//  Copyright © 2020 Stanley. All rights reserved.
//

import XCTest
@testable import AirQuality_RxSwift
import RxSwift

class AirQualityVCViewModelTests: XCTestCase {
    var sut: AirQualityVCViewModel!
    var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        sut = AirQualityVCViewModel()
        disposeBag = DisposeBag()
    }
    
    override func tearDown() {
        sut = nil
        disposeBag = nil
        super.tearDown()
    }
    
    func testFilterCountryId() throws {
        let path = Bundle(for: type(of: self)).path(forResource: "AirQuality", ofType: "json")
        let data = try? Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped)
        do {
            if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: []) as? [Any] {
                for result in jsonResult {
                    if let dic = result as? [String: Any] {
                        let airQualityModel = AirQualityObj(dicData: dic)
                        sut.originAirQualityDatas.append(airQualityModel)
                    }
                }
            }
            sut.selectedCountryId = 2
            sut.airQualityDatas.subscribe(onNext: { (datas) in
                XCTAssertEqual(datas.filter({ $0.countryId != 1 }).count, 0)
            }).disposed(by: disposeBag)
        }
        catch {
            XCTFail("json parser fail")
        }
    }

}
