//
//  AirQualityVCViewModel.swift
//  AirQuality_RxSwift
//
//  Created by Dlink on 2020/8/20.
//  Copyright © 2020 Dlink. All rights reserved.
//

import Foundation
import RxRelay

class AirQualityVCViewModel {    
    weak var coordinator: MainCoordinator?
    
    var strRequestError = PublishRelay<String>()
    var isHiddenLoading = PublishRelay<Bool>()
    var airQualityDatas = PublishRelay<Array<AirQualityObj>>()
    var originAirQualityDatas = Array<AirQualityObj>()
    var selectedCountryId = -1 {
        didSet {
            filterDataBySelectedCountryIndex()
        }
    }
    
    init() {
        
    }
    
    func queryAirQualityAPIData() {
        isHiddenLoading.accept(false)
        APIManager.getAirQuality { [unowned self] (aryDatas, failure) in
            self.isHiddenLoading.accept(true)
            if let error = failure {
                self.strRequestError.accept(error.localizedDescription)
            }
            else {
                self.originAirQualityDatas = Array<AirQualityObj>()
                for result in aryDatas! {
                    if let dic = result as? Dictionary<String, Any> {
                        let airQualityModel = AirQualityObj(dicData: dic)
                        self.configCountryId(airQualityModel: airQualityModel)
                        self.originAirQualityDatas.append(airQualityModel)
                    }
                }
                self.originAirQualityDatas = self.originAirQualityDatas.sorted(by: { $0.countryId < $1.countryId })
                self.filterDataBySelectedCountryIndex()
            }
        }
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
    
    //MARK: - private function
    private func getCountryList() -> Array<String> {
        var countryAry = Array<String>()
        for airQuality in originAirQualityDatas {
            if !countryAry.contains(airQuality.country) {
                countryAry.append(airQuality.country)
            }
        }
        countryAry.insert("全部", at: 0)
        return countryAry
    }
    
    private func configCountryId(airQualityModel: AirQualityObj) {
        switch airQualityModel.country {
        case "基隆市":
            airQualityModel.countryId = 0
            break
        case "臺北市":
            airQualityModel.countryId = 1
            break
        case "新北市":
            airQualityModel.countryId = 2
            break
        case "桃園市":
            airQualityModel.countryId = 3
            break
        case "新竹縣":
            airQualityModel.countryId = 4
            break
        case "新竹市":
            airQualityModel.countryId = 5
            break
        case "苗栗縣":
            airQualityModel.countryId = 6
            break
        case "臺中市":
            airQualityModel.countryId = 7
            break
        case "彰化縣":
            airQualityModel.countryId = 8
            break
        case "南投縣":
            airQualityModel.countryId = 9
            break
        case "雲林縣":
            airQualityModel.countryId = 10
            break
        case "嘉義縣":
            airQualityModel.countryId = 11
            break
        case "嘉義市":
            airQualityModel.countryId = 12
            break
        case "臺南市":
            airQualityModel.countryId = 13
            break
        case "高雄市":
            airQualityModel.countryId = 14
            break
        case "屏東縣":
            airQualityModel.countryId = 15
            break
        case "宜蘭縣":
            airQualityModel.countryId = 16
            break
        case "花蓮縣":
            airQualityModel.countryId = 17
            break
        case "臺東縣":
            airQualityModel.countryId = 18
            break
        case "澎湖縣":
            airQualityModel.countryId = 19
            break
        case "金門縣":
            airQualityModel.countryId = 20
            break
        case "連江縣":
            airQualityModel.countryId = 21
            break
            
        default:
            break
        }
    }
    
    private func filterDataBySelectedCountryIndex() {
        var result = Array<AirQualityObj>()
        if selectedCountryId == -1 {
            airQualityDatas.accept(originAirQualityDatas)
        }
        else {
            for airQuality in originAirQualityDatas {
                if airQuality.countryId == selectedCountryId {
                    result.append(airQuality)
                }
            }
            airQualityDatas.accept(result)
        }
    }
}
