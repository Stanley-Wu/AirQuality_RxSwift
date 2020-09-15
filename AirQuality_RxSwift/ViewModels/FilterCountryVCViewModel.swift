//
//  FilterCountryVCViewModel.swift
//  AirQuality_RxSwift
//
//  Created by Stanley on 2020/9/2.
//  Copyright © 2020 Stanley. All rights reserved.
//

import Foundation
import RxRelay

class FilterCountryVCViewModel {
    
    weak var coordinator: MainCoordinator?
    var countryDatas = BehaviorRelay<[String]>(value: [])
    var selectedCountryId = -1 {
        willSet {
            countryDatas.accept(countryDatas.value)
        }
    }
    
    init(countryDatas: [String], selectedCountryId: Int) {
        self.countryDatas.accept(countryDatas)
        self.selectedCountryId = selectedCountryId
    }
    
    func dismissToPreviousVC() {
        coordinator?.dismissFilterCountry(selectedCountryId: selectedCountryId)
    }
}
