//
//  SettingsViewController.swift
//  EsLight
//
//  Created by Yura Menschikov on 6/16/20.
//  Copyright © 2020 Yura Menschikov. All rights reserved.
//

import UIKit
import CoreBluetooth
import QuartzCore

final class SettingsViewController: UIViewController {
    
    let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        createStuffSettings()
    }
    
    func createStuffSettings() {
        self.view.backgroundColor = UIColor(red: (33/255.0), green: (33/255.0), blue: (33/255.0), alpha: 1.0)
        self.navigationItem.title = "Settings"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(goBackButton(sender:)))
        
        label.frame = CGRect(x: 20, y: 80, width: 335, height: 140)
        label.backgroundColor = UIColor.white
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        label.layer.borderWidth = 1
        label.tintColor = UIColor.black
        label.numberOfLines = 5
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.text = "EsLight Control v 1.13.3 \n Minsk 2020 \n All rights reserved"
        label.textAlignment = .center
        self.view.addSubview(label)
    }
    
    @objc func goBackButton(sender: UITextField) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
