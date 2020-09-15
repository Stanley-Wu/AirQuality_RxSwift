//
//  AirQualityVCViewModel.swift
//  AirQuality_RxSwift
//
//  Created by Stanley on 2020/8/20.
//  Copyright © 2020 Stanley. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay

class AirQualityVCViewModel {    
    weak var coordinator: MainCoordinator?
    
    var strRequestError = PublishRelay<String>()
    var isHiddenLoading = PublishRelay<Bool>()
    var airQualityDatas = PublishRelay<[AirQualityObj]>()
    var originAirQualityDatas = [AirQualityObj]()
    var selectedCountryId = -1 {
        didSet {
            filterDataBySelectedCountryIndex()
        }
    }
    var disposeBag: DisposeBag!
    
    init() {
        disposeBag = DisposeBag()
    }
    
    func queryAirQualityAPIData() {
        isHiddenLoading.accept(false)
        APIManager.getAirQuality()
            .subscribe(
                onSuccess: { [unowned self] (aryDatas) in
                    self.isHiddenLoading.accept(true)
                    self.originAirQualityDatas = [AirQualityObj]()
                    for result in aryDatas {
                        if let dic = result as? [String: Any] {
                            let airQualityModel = AirQualityObj(dicData: dic)
                            self.configCountryId(airQualityModel: airQualityModel)
                            self.originAirQualityDatas.append(airQualityModel)
                        }
                    }
                    self.originAirQualityDatas = self.originAirQualityDatas.sorted(by: { $0.countryId < $1.countryId })
                    self.filterDataBySelectedCountryIndex()
                },
                onError: { [unowned self] (error) in
                    self.isHiddenLoading.accept(true)
                    self.strRequestError.accept(error.localizedDescription)
            })
            .disposed(by: disposeBag)
    }
    
    func pushToWeatherForecast() {
        coordinator?.pushToWeatherForecast(selectedCountryId: selectedCountryId)
    }
    
    func presentFilterCountry() {
        coordinator?.presentToFilterCountry(datas: getCountryList(),
                                            selectedCountryId: selectedCountryId,
                                            dismissFilterCountry: { [unowned self] (selectedCountryId) in
                                                self.selectedCountryId = selectedCountryId
                                            })
    }
    
    // MARK: - private function
    private func getCountryList() -> [String] {
        var countryAry = [String]()
        for airQuality in originAirQualityDatas {
            if !countryAry.contains(airQuality.country) {
                countryAry.append(airQuality.country)
            }
        }
        countryAry.insert("全部", at: 0)
        return countryAry
    }
    
    // swiftlint:disable cyclomatic_complexity
    private func configCountryId(airQualityModel: AirQualityObj) {
        switch airQualityModel.country {
        case "基隆市":
            airQualityModel.countryId = 0
        case "臺北市":
            airQualityModel.countryId = 1
        case "新北市":
            airQualityModel.countryId = 2
        case "桃園市":
            airQualityModel.countryId = 3
        case "新竹縣":
            airQualityModel.countryId = 4
        case "新竹市":
            airQualityModel.countryId = 5
        case "苗栗縣":
            airQualityModel.countryId = 6
        case "臺中市":
            airQualityModel.countryId = 7
        case "彰化縣":
            airQualityModel.countryId = 8
        case "南投縣":
            airQualityModel.countryId = 9
        case "雲林縣":
            airQualityModel.countryId = 10
        case "嘉義縣":
            airQualityModel.countryId = 11
        case "嘉義市":
            airQualityModel.countryId = 12
        case "臺南市":
            airQualityModel.countryId = 13
        case "高雄市":
            airQualityModel.countryId = 14
        case "屏東縣":
            airQualityModel.countryId = 15
        case "宜蘭縣":
            airQualityModel.countryId = 16
        case "花蓮縣":
            airQualityModel.countryId = 17
        case "臺東縣":
            airQualityModel.countryId = 18
        case "澎湖縣":
            airQualityModel.countryId = 19
        case "金門縣":
            airQualityModel.countryId = 20
        case "連江縣":
            airQualityModel.countryId = 21
        default:
            break
        }
    }
    // swiftlint:enable cyclomatic_complexity
    
    private func filterDataBySelectedCountryIndex() {
        var result = [AirQualityObj]()
        if selectedCountryId == -1 {
            airQualityDatas.accept(originAirQualityDatas)
        }
        else {
            for airQuality in originAirQualityDatas where airQuality.countryId == selectedCountryId {
                result.append(airQuality)
            }
            airQualityDatas.accept(result)
        }
    }
}
