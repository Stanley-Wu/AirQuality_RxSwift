//
//  WeatherForecastVC.swift
//  AirQuality_RxSwift
//
//  Created by Dlink on 2020/9/1.
//  Copyright © 2020 Dlink. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class WeatherForecastVC: BaseViewController {
    
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnLocation: UIButton!
    
    private var viewModel: WeatherForecastVCViewModel!
    private var disposeBag = DisposeBag()
    
    convenience init(viewModel: WeatherForecastVCViewModel) {
        self.init(nibName: "WeatherForecastVC", bundle: nil)
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Weather"
        
        bindUIComponent()
        bindRequestError()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.queryWeatherForecastAPIData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel.popSelf()
        disposeBag = DisposeBag()
    }
    
    // MARK: - private function
    private func bindUIComponent() {
        bindTableView()
        
        viewModel.isHiddenLoading.bind(to: loadingView.rx.isHidden).disposed(by: disposeBag)
        
        btnLocation.rx.tap.subscribe(onNext: { [unowned self] () in
            self.viewModel.presentFilterCountry()
        }).disposed(by: disposeBag)
    }
    
    private func bindTableView() {
        tableView.register(UINib(nibName: "WeatherForecastCell", bundle: nil), forCellReuseIdentifier: "WeatherForecastCell")
        tableView.register(UINib(nibName: "WeatherForecastHeader", bundle: nil),
                           forHeaderFooterViewReuseIdentifier: "WeatherForecastHeader")
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 40.0))
        
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        tableView.rx.itemSelected.subscribe(onNext: { [unowned self] (indexPath) in
            self.tableView.deselectRow(at: indexPath, animated: false)
        }).disposed(by: disposeBag)
        
        // swiftlint:disable line_length
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<WeatherForecastObj, ForecastObj>>(configureCell: { _, tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherForecastCell", for: indexPath) as! WeatherForecastCell
            cell.forecastObj = item
            cell.margin = 20.0
            return cell
        })
        // swiftlint:enable line_length
        viewModel.dataSource = dataSource
        
        viewModel.tableDatas.bind(to: tableView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
    }
    
    private func bindRequestError() {
        viewModel.strRequestError.subscribe(onNext: { [unowned self] (strError) in
            self.showRequestError(strError)
        }).disposed(by: disposeBag)
    }
    
    private func showRequestError(_ strError: String) {
        showAlert(title: "Error", message: strError)
    }
    
}

// MARK: - Extension
extension WeatherForecastVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 90.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.cellRowHeightAt(indexPath.section)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "WeatherForecastHeader") as! WeatherForecastHeader
        if let weatherForecast = viewModel.dataSource?[section].model {
            header.weatherForecast = weatherForecast
        }
        header.onClick = { [unowned self] in
            self.viewModel.expandSectionIdx = section
        }
        return header
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.roundUpCorners([.topRight, .topLeft, .bottomRight, .bottomLeft], radius: 0)
        
        let rowCount = tableView.numberOfRows(inSection: indexPath.section)
        if indexPath.row == rowCount - 1 {
            cell.roundUpCorners([.bottomRight, .bottomLeft], radius: 10)
        }
    }
}
