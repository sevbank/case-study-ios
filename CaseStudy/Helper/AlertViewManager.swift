//
//  AlertViewManager.swift
//  CaseStudy
//
//  Created by Sevban Kocabas on 23.01.2020.
//  Copyright © 2020 Sevban Kocabas. All rights reserved.
//

import UIKit
import Foundation

class AlertViewManager {
    static let instance = AlertViewManager()
    
    func showAlertController(withTitle:String, andMessage:String, viewController:UIViewController){
        let alertController = UIAlertController(title: withTitle, message: andMessage, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        viewController.present(alertController, animated: true, completion: nil)
        
    }
}
