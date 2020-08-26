//
//  ExtensionsUIViewController.swift
//  EsLightControl
//
//  Created by Yura Menschikov on 8/26/20.
//  Copyright © 2020 Yura Menschikov. All rights reserved.
//

import UIKit

// MARK: - ExtensionsUIViewController

extension UIViewController {
    
    func presentAlert(withTitle title: String, message : String) {
       let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
       let OKAction = UIAlertAction(title: "OK", style: .default) { action in
           print("You've pressed OK Button")
       }
       alertController.addAction(OKAction)
       self.present(alertController, animated: true, completion: nil)
     }
}
