//
//  BaseViewController.swift
//  AppDesignPattern
//
//  Created by Dlink on 2018/2/6.
//  Copyright © 2018年 Stanley. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController, ViewControllerProtocol {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillShow(notification:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillHide(notification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
        
        self.navigationController?.navigationBar.tintColor = ColorManager.darkSilver()
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
    }
    
    func showAlert(title: String?, message: String?) {
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}

protocol ViewControllerProtocol {
    static func instantiate() -> Self
}

extension ViewControllerProtocol where Self: UIViewController {
    static func instantiate() -> Self {
        let fullName = NSStringFromClass(self)
        let className = fullName.components(separatedBy: ".")[1]
        return self.init(nibName: className, bundle: nil)
    }
}
