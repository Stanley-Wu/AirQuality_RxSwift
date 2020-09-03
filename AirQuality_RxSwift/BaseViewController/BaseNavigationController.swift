//
//  BaseNavigationController.swift
//  AppDesignPattern
//
//  Created by Dlink on 2018/2/6.
//  Copyright © 2018年 Stanley. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController, UINavigationControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: ColorManager.darkSilver()]
        self.navigationBar.barTintColor = ColorManager.lightBlue()
    }
    
}
