//
//  WeatherForecastVCViewModel.swift
//  AirQuality_RxSwift
//
//  Created by Stanley on 2020/9/1.
//  Copyright © 2020 Stanley. All rights reserved.
//

import Foundation
import RxRelay
import RxDataSources

class WeatherForecastVCViewModel {
    weak var coordinator: MainCoordinator?
    
    var strRequestError = PublishRelay<String>()
    var isHiddenLoading = PublishRelay<Bool>()
    var tableDatas = PublishRelay<[SectionModel<WeatherForecastObj, ForecastObj>]>()
    var dataSource: RxTableViewSectionedReloadDataSource<SectionModel<WeatherForecastObj, ForecastObj>>?
    var originalWeatherForecastDatas = [WeatherForecastObj]()
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
                self.originalWeatherForecastDatas = [WeatherForecastObj]()
                if let records = dicWeather!["records"] as? [String: Any] {
                    if let locations = records["location"] as? [[String: Any]] {
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
    
    // MARK: - private function
    private func getCountryList() -> [String] {
        var countryAry = [String]()
        for weatherForecastModel in originalWeatherForecastDatas {
            if !countryAry.contains(weatherForecastModel.locationName) {
                countryAry.append(weatherForecastModel.locationName)
            }
        }
        countryAry.insert("全部", at: 0)
        return countryAry
    }
    
    // swiftlint:disable cyclomatic_complexity
    private func configLocationId(weatherForecastModel: WeatherForecastObj) {
        switch weatherForecastModel.locationName {
        case "基隆市":
            weatherForecastModel.locationId = 0
        case "臺北市":
            weatherForecastModel.locationId = 1
        case "新北市":
            weatherForecastModel.locationId = 2
        case "桃園市":
            weatherForecastModel.locationId = 3
        case "新竹縣":
            weatherForecastModel.locationId = 4
        case "新竹市":
            weatherForecastModel.locationId = 5
        case "苗栗縣":
            weatherForecastModel.locationId = 6
        case "臺中市":
            weatherForecastModel.locationId = 7
        case "彰化縣":
            weatherForecastModel.locationId = 8
        case "南投縣":
            weatherForecastModel.locationId = 9
        case "雲林縣":
            weatherForecastModel.locationId = 10
        case "嘉義縣":
            weatherForecastModel.locationId = 11
        case "嘉義市":
            weatherForecastModel.locationId = 12
        case "臺南市":
            weatherForecastModel.locationId = 13
        case "高雄市":
            weatherForecastModel.locationId = 14
        case "屏東縣":
            weatherForecastModel.locationId = 15
        case "宜蘭縣":
            weatherForecastModel.locationId = 16
        case "花蓮縣":
            weatherForecastModel.locationId = 17
        case "臺東縣":
            weatherForecastModel.locationId = 18
        case "澎湖縣":
            weatherForecastModel.locationId = 19
        case "金門縣":
            weatherForecastModel.locationId = 20
        case "連江縣":
            weatherForecastModel.locationId = 21
        default:
            break
        }
    }
    // swiftlint:enable cyclomatic_complexity
    
    private func filterDataBySelectedCountryIndex() {
        var result = [WeatherForecastObj]()
        if selectedCountryId == -1 {
            result = originalWeatherForecastDatas
        }
        else {
            for weatherForecastModel in originalWeatherForecastDatas where weatherForecastModel.locationId == selectedCountryId {
                result.append(weatherForecastModel)
            }
        }
        
        var sections: [SectionModel<WeatherForecastObj, ForecastObj>] = []
        for section in result {
            sections.append(SectionModel(model: section, items: section.forecast))
        }
        self.tableDatas.accept(sections)
    }
    
}
