//
//  FilterCountryVC.swift
//  AirQuality_RxSwift
//
//  Created by Stanley on 2020/9/2.
//  Copyright © 2020 Stanley. All rights reserved.
//

import UIKit
import RxSwift

class FilterCountryVC: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel: FilterCountryVCViewModel!
    private var disposeBag = DisposeBag()
    
    convenience init(viewModel: FilterCountryVCViewModel) {
        self.init(nibName: "FilterCountryVC", bundle: nil)
        
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Location"
        
        bindNavigationBtn()
        bindTableView()        
    }
    
    // MARK: - private function
    private func bindNavigationBtn() {
        let customBackButton = UIBarButtonItem(barButtonSystemItem: .reply, target: nil, action: nil)
        customBackButton.rx.tap.subscribe(onNext: { [unowned self] () in
            self.dismiss(animated: true, completion: nil)
        }).disposed(by: disposeBag)
        self.navigationItem.leftBarButtonItem = customBackButton
    }
    
    private func bindTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        tableView.rx.itemSelected.subscribe(onNext: { [unowned self] (indexPath) in
            self.viewModel.selectedCountryId = indexPath.row - 1
            self.viewModel.dismissToPreviousVC()
        }).disposed(by: disposeBag)
        
        viewModel.countryDatas.bind(to: tableView.rx.items) { [unowned self] (tableView, row, strCountry) in
            let indexPath = IndexPath(row: row, section: 0)
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            cell.textLabel?.text = strCountry
            cell.accessoryType = self.viewModel.selectedCountryId == (row - 1) ? .checkmark : .none
            return cell
        }.disposed(by: disposeBag)
    }
    
}
