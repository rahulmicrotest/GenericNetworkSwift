//
//  UIViewControllerExtension.swift
//  DeltaTest
//
//  Created by Rahul Singh on 19/04/19.
//  Copyright © 2019 Rahul Singh. All rights reserved.
//

import Foundation
import MBProgressHUD

extension UIViewController {
    
    // MARK: - Public methods
    /*
     call this method to show Alert
   */
    func showAlertWith(message: AlertMessage , style: UIAlertController.Style = .alert) {
        let alertController = UIAlertController(title: message.title, message: message.body, preferredStyle: style)
        let action = UIAlertAction(title: "Ok", style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
    /*
      call this method to show Hide Activity Indicator by passing isHidden true/false
   */
    func shouldHideLoader(isHidden: Bool) {
        if isHidden {
            MBProgressHUD.hide(for: self.view, animated: true)
        } else {
            MBProgressHUD.showAdded(to: self.view, animated: true)
        }
    }
    
}
