//
//  WeatherForecastHeader.swift
//  AirQuality
//
//  Created by Dlink on 2018/3/5.
//  Copyright © 2018年 Stanley. All rights reserved.
//

import UIKit

class WeatherForecastHeader: UITableViewHeaderFooterView {
    @IBOutlet weak var roundedView: UIView!
    @IBOutlet weak var lbCountry: UILabel!
    @IBOutlet weak var lbWx: UILabel!
    @IBOutlet weak var lbMaxT: UILabel!
    @IBOutlet weak var lbMinT: UILabel!
    
    var weatherForecast: WeatherForecastObj = WeatherForecastObj(dicData: [:]) {
        willSet {
            lbCountry.text = newValue.locationName
            lbWx.text = newValue.forecast.first!.nameWx
            lbMaxT.text = newValue.forecast.first!.nameMaxT + " C"
            lbMinT.text = newValue.forecast.first!.nameMinT + " C"
            configWeatherForecastHeaderLabelColor(forecast: newValue.forecast.first!)
        }
    }
    var onClick: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        clipsToBounds = false
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 2, height: 2)
        roundedView.layer.cornerRadius = 10.0
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.didClickWeatherForecastHeader))
        self.addGestureRecognizer(gesture)
    }
    
    //MARK: - private function
    private func configWeatherForecastHeaderLabelColor(forecast: ForecastObj) {
        if let maxT = Int(forecast.nameMaxT) {
            if maxT > 27 {
                lbMaxT.textColor = ColorManager.red()
            }
            else if maxT > 24 {
                lbMaxT.textColor = ColorManager.orange()
            }
            else if maxT > 20 {
                lbMaxT.textColor = ColorManager.green()
            }
            else {
                lbMaxT.textColor = ColorManager.blue()
            }
        }
        
        if let minT = Int(forecast.nameMinT) {
            if minT > 27 {
                lbMinT.textColor = ColorManager.red()
            }
            else if minT > 24 {
                lbMinT.textColor = ColorManager.orange()
            }
            else if minT > 20 {
                lbMinT.textColor = ColorManager.green()
            }
            else {
                lbMinT.textColor = ColorManager.blue()
            }
        }
    }
    
    @objc private func didClickWeatherForecastHeader() {
        onClick?()
    }
}
