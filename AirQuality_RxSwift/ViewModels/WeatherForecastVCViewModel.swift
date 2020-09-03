//
//  WeatherForecastVCViewModel.swift
//  AirQuality_RxSwift
//
//  Created by Dlink on 2020/9/1.
//  Copyright © 2020 Dlink. All rights reserved.
//

import Foundation
import RxRelay
import RxDataSources

class WeatherForecastVCViewModel {
    weak var coordinator: MainCoordinator?
    
    var strRequestError = PublishRelay<String>()
    var isHiddenLoading = PublishRelay<Bool>()
    var tableDatas = PublishRelay<Array<SectionModel<WeatherForecastObj, ForecastObj>>>()
    var dataSource: RxTableViewSectionedReloadDataSource<SectionModel<WeatherForecastObj, ForecastObj>>?
    var originalWeatherForecastDatas = Array<WeatherForecastObj>()
    var selectedCountryId: Int = -1 {
        didSet {
            filterDataBySelectedCountryIndex()
        }
    }
    var expandSectionIdx: Int = -1 {
        didSet {
            if expandSectionIdx == oldValue {
                expandSectionIdx = -1
            }
            filterDataBySelectedCountryIndex()
        }
    }
    
    init(selectedCountryId: Int) {
        self.selectedCountryId = selectedCountryId
    }
    
    func queryWeatherForecastAPIData() {
        isHiddenLoading.accept(false)
        APIManager.getWeatherForecast { [unowned self] (dicWeather, failure) in
            self.isHiddenLoading.accept(true)
            if let error = failure {
                self.strRequestError.accept(error.localizedDescription)
            }
            else {
                self.originalWeatherForecastDatas = Array<WeatherForecastObj>()
                if let records = dicWeather!["records"] as? Dictionary<String, Any> {
                    if let locations = records["location"] as? Array<Dictionary<String, Any>> {
                        for location in locations {
                            let weatherForecast = WeatherForecastObj(dicData: location)
                            
                            self.configLocationId(weatherForecastModel: weatherForecast)
                            self.originalWeatherForecastDatas.append(weatherForecast)
                        }
                    }
                }
                self.originalWeatherForecastDatas = self.originalWeatherForecastDatas.sorted(by: { $0.locationId < $1.locationId })
                self.filterDataBySelectedCountryIndex()
            }
        }
    }
    
    func presentFilterCountry() {
        coordinator?.presentToFilterCountry(datas: getCountryList(),
                                            selectedCountryId: selectedCountryId,
                                            dismissFilterCountry: { [unowned self] (selectedCountryId) in
                                                self.selectedCountryId = selectedCountryId
                                            })
    }
    
    func popSelf() {
        coordinator?.popFromWeatherForecast(selectedCountryId: selectedCountryId)
    }
    
    func cellRowHeightAt(_ section: Int) -> CGFloat {
        if section == expandSectionIdx {
            return 80.0
        }
        return CGFloat.leastNormalMagnitude
    }
    
    //MARK: - private function
    private func getCountryList() -> Array<String> {
        var countryAry = Array<String>()
        for weatherForecastModel in originalWeatherForecastDatas {
            if !countryAry.contains(weatherForecastModel.locationName) {
                countryAry.append(weatherForecastModel.locationName)
            }
        }
        countryAry.insert("全部", at: 0)
        return countryAry
    }
    
    private func configLocationId(weatherForecastModel: WeatherForecastObj) {
        switch weatherForecastModel.locationName {
        case "基隆市":
            weatherForecastModel.locationId = 0
            break
        case "臺北市":
            weatherForecastModel.locationId = 1
            break
        case "新北市":
            weatherForecastModel.locationId = 2
            break
        case "桃園市":
            weatherForecastModel.locationId = 3
            break
        case "新竹縣":
            weatherForecastModel.locationId = 4
            break
        case "新竹市":
            weatherForecastModel.locationId = 5
            break
        case "苗栗縣":
            weatherForecastModel.locationId = 6
            break
        case "臺中市":
            weatherForecastModel.locationId = 7
            break
        case "彰化縣":
            weatherForecastModel.locationId = 8
            break
        case "南投縣":
            weatherForecastModel.locationId = 9
            break
        case "雲林縣":
            weatherForecastModel.locationId = 10
            break
        case "嘉義縣":
            weatherForecastModel.locationId = 11
            break
        case "嘉義市":
            weatherForecastModel.locationId = 12
            break
        case "臺南市":
            weatherForecastModel.locationId = 13
            break
        case "高雄市":
            weatherForecastModel.locationId = 14
            break
        case "屏東縣":
            weatherForecastModel.locationId = 15
            break
        case "宜蘭縣":
            weatherForecastModel.locationId = 16
            break
        case "花蓮縣":
            weatherForecastModel.locationId = 17
            break
        case "臺東縣":
            weatherForecastModel.locationId = 18
            break
        case "澎湖縣":
            weatherForecastModel.locationId = 19
            break
        case "金門縣":
            weatherForecastModel.locationId = 20
            break
        case "連江縣":
            weatherForecastModel.locationId = 21
            break
            
        default:
            break
        }
    }
    
    private func filterDataBySelectedCountryIndex() {
        var result = Array<WeatherForecastObj>()
        if selectedCountryId == -1 {
            result = originalWeatherForecastDatas
        }
        else {
            for weatherForecastModel in originalWeatherForecastDatas {
                if weatherForecastModel.locationId == selectedCountryId {
                    result.append(weatherForecastModel)
                }
            }
        }
        
        var sections: Array<SectionModel<WeatherForecastObj, ForecastObj>> = []
        for section in result {
            sections.append(SectionModel(model: section, items: section.forecast))
        }
        self.tableDatas.accept(sections)
    }
    
}
