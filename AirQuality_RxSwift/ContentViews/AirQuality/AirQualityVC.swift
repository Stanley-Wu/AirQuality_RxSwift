//
//  AirQualityVC.swift
//  AirQuality_RxSwift
//
//  Created by Stanley on 2020/8/20.
//  Copyright © 2020 Stanley. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class AirQualityVC: BaseViewController {
    
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnLocation: UIButton!
    
    var viewModel: AirQualityVCViewModel!
    private var disposeBag = DisposeBag()
    
    convenience init(viewModel: AirQualityVCViewModel) {
        self.init(nibName: "AirQualityVC", bundle: nil)
        
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Air Quality"
        
        bindNavigationBtn()
        bindUIComponent()
        bindRequestError()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.queryAirQualityAPIData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        disposeBag = DisposeBag()
    }
    
    // MARK: - private function
    private func bindNavigationBtn() {
        self.navigationItem.hidesBackButton = true
        let customBackButton = UIBarButtonItem(title: "Weather", style: .done,
                                                   target: nil, action: nil)
        customBackButton.rx.tap
            .subscribe(onNext: { [unowned self] () in
                self.viewModel.pushToWeatherForecast()
            })
            .disposed(by: disposeBag)
        self.navigationItem.rightBarButtonItem = customBackButton
    }
    
    private func bindUIComponent() {
        bindTableView()
        
        viewModel.isHiddenLoading
            .bind(to: loadingView.rx.isHidden)
            .disposed(by: disposeBag)
        
        btnLocation.rx.tap
            .subscribe(onNext: { [unowned self] () in
                self.viewModel.presentFilterCountry()
            })
            .disposed(by: disposeBag)
    }
    
    private func bindTableView() {
        tableView.register(UINib(nibName: "AirQualityCell", bundle: nil), forCellReuseIdentifier: "AirQualityCell")
        
        tableView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .subscribe(onNext: { [unowned self] (indexPath) in
                self.presentSelectedCountryDetail(at: indexPath)
            })
            .disposed(by: disposeBag)
        
        viewModel.airQualityDatas
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .userInitiated))
            .observeOn(MainScheduler.instance)
            .bind(to: tableView.rx.items) { (tableView, row, airQualityObj) in
                let indexPath = IndexPath(row: row, section: 0)
                let cell = tableView.dequeueReusableCell(withIdentifier: "AirQualityCell", for: indexPath) as! AirQualityCell
                cell.airQualityObj = airQualityObj
                cell.margin = 15.0
                return cell
            }
            .disposed(by: disposeBag)
    }
    
    private func bindRequestError() {
        viewModel.strRequestError
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .userInitiated))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [unowned self] (strError) in
                self.showRequestError(strError)
            })
            .disposed(by: disposeBag)
    }
    
    private func presentSelectedCountryDetail(at indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        let airQualityModel: AirQualityObj = try! tableView.rx.model(at: indexPath)
        let title = String(format: "%@ - %@",
                           airQualityModel.country,
                           airQualityModel.siteName)
        let message = String(format: "一氧化碳：%@ ppm\n臭氧：%@ ppb\nPM10：%@ μg/m3\n風速：%@ m/sec",
                             airQualityModel.co,
                             airQualityModel.o3,
                             airQualityModel.pm10,
                             airQualityModel.windSpeed)
        
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func showRequestError(_ strError: String) {
        showAlert(title: "Error", message: strError)
    }
    
}

// MARK: - Extension
extension AirQualityVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }
}
