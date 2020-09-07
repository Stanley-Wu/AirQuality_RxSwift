//
//  MainCoordinator.swift
//  AirQuality_RxSwift
//
//  Created by Dlink on 2020/9/2.
//  Copyright © 2020 Dlink. All rights reserved.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var completeDismissFilterCountry: ((Int) -> Void)?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vm = AirQualityVCViewModel()
        vm.coordinator = self
        let vc = AirQualityVC(viewModel: vm)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func pushToWeatherForecast(selectedCountryId: Int) {
        let vm = WeatherForecastVCViewModel(selectedCountryId: selectedCountryId)
        vm.coordinator = self
        let vc = WeatherForecastVC(viewModel: vm)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func popFromWeatherForecast(selectedCountryId: Int) {
        for vc in navigationController.viewControllers {
            if let vc = vc as? AirQualityVC {
                vc.viewModel.selectedCountryId = selectedCountryId
                break
            }
        }
    }
    
    func presentToFilterCountry(datas: [String], selectedCountryId: Int, dismissFilterCountry: @escaping(Int) -> Void) {
        let vm = FilterCountryVCViewModel(countryDatas: datas, selectedCountryId: selectedCountryId)
        vm.coordinator = self
        let nv = BaseNavigationController(rootViewController: FilterCountryVC(viewModel: vm))
        nv.modalPresentationStyle = .automatic
        navigationController.present(nv, animated: true, completion: nil)
        completeDismissFilterCountry = dismissFilterCountry
    }
    
    func dismissFilterCountry(selectedCountryId: Int) {
        completeDismissFilterCountry?(selectedCountryId)
        navigationController.dismiss(animated: true, completion: nil)
    }
}
