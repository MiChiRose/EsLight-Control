//
//  ViewController.swift
//  EsLight
//
//  Created by Yura Menschikov on 6/16/20.
//  Copyright © 2020 Yura Menschikov. All rights reserved.
//

import UIKit
import CoreBluetooth
import QuartzCore

// MARK: - ViewController

@available (iOS 13.0, *)
final class ViewController: UIViewController, UITextFieldDelegate, BluetoothSerialDelegate { //To:Do  ViewController - Peremienovat
    
    // MARK: - Public properties
    
    private lazy var onButton = UIButton()
    private lazy var offButton = UIButton()
    lazy var group1 = UISegmentedControl()
    lazy var group2 = UISegmentedControl()
    lazy var group3 = UISegmentedControl()
    lazy var group4 = UISegmentedControl()
    lazy var percentGroup = UISegmentedControl()
    
    var segment = UISegmentedControl()

    //To:Do - ne delati tipi : String
    var data: String = ""
    var segmentArrayONOFF: Array = ["OFF","ON"]
    var segmentArray255075 = ["25%","50%","75%"]
    let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
    let segmentFont = UIFont.boldSystemFont(ofSize: 14)
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        serial = BluetoothSerial(delegate: self)
        
        reloadView()
        createStuff()
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.reloadView), name: NSNotification.Name(rawValue: "reloadStartViewController"), object: nil)
        
        onButton = createButtons(color: UIColor(red: (180/255.0), green: (197/255.0), blue: (64/255.0), alpha: 1.0), title: "ON", action: #selector(onButtonPressed))
        view.addSubview(onButton)
        onButton.translatesAutoresizingMaskIntoConstraints = false
        
        onButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 80).isActive = true
        onButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100).isActive = true
        
        offButton = createButtons(color: UIColor(red: (198/255.0), green: (64/255.0), blue: (64/255.0), alpha: 1.0), title: "OFF", action: #selector(offButtonPressed))
        
        view.addSubview(offButton)
        offButton.translatesAutoresizingMaskIntoConstraints = false
        offButton.leftAnchor.constraint(equalTo: onButton.leftAnchor, constant: 150).isActive = true
        offButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100).isActive = true
        
        
        //MARK: Replace CGRect to Anchors (if it is possible)
        group1 = createSegments(item: segmentArrayONOFF, x: 30, y: 220, width: 150, color: UIColor(red: (87/255.0), green: (90/255.0), blue: (108/255.0), alpha: 1.0), target: #selector(firstGroupFunc))
        
        group2 = createSegments(item: segmentArrayONOFF, x: 230, y: 220, width: 150, color: UIColor(red: (87/255.0), green: (90/255.0), blue: (108/255.0), alpha: 1.0), target: #selector(secondGroupFunc))
        
        group3 = createSegments(item: segmentArrayONOFF, x: 30, y: 340, width: 150, color: UIColor(red: (87/255.0), green: (90/255.0), blue: (108/255.0), alpha: 1.0), target: #selector(thirdGroupFunc))
        
        group4 = createSegments(item: segmentArrayONOFF, x: 230, y: 340, width: 150, color: UIColor(red: (87/255.0), green: (90/255.0), blue: (108/255.0), alpha: 1.0), target: #selector(fourthGroupFunc))
        
        percentGroup = createSegments(item: segmentArray255075, x: 30, y: 460, width: 350, color: UIColor(red: (54/255.0), green: (134/255.0), blue: (201/255.0), alpha: 1.0), target: #selector(percentGroupFunc))
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: Actions
    @objc
    private func reloadView() {
        // in case we're the visible view again
        serial.delegate = self
        
        if serial.isReady {
            navigationItem.title = serial.connectedPeripheral!.name
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Disconnect", style: .plain, target: self, action: #selector(pressToConnect(sender:)))
        } else if serial.centralManager.state == .poweredOn {
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Connect", style: .plain, target: self, action: #selector(pressToConnect(sender:)))
            navigationItem.leftBarButtonItem?.isEnabled = true
        } else {
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Connect", style: .plain, target: self, action: #selector(pressToConnect(sender:)))
            navigationItem.leftBarButtonItem?.isEnabled = false
        }
    }
    
    //MARK: Buttons action
    @objc
     func pressToSettings(sender: UITextField) {
        let settings = SettingsViewController()
        navigationController?.pushViewController(settings, animated: true)
    }
    
    @objc
     func pressToConnect(sender: UITextField) {
        let connect = ConnectViewController()
        self.navigationController?.pushViewController(connect, animated: true)
    }
    
    //MARK: BluetoothSerialDelegate
    func serialDidDisconnect(_ peripheral: CBPeripheral, error: NSError?) {
        reloadView()
        presentAlert(withTitle: "Disconnected", message: "")

    }
    
    func serialDidChangeState() {
        reloadView()
        if serial.centralManager.state != .poweredOn {
            presentAlert(withTitle: "Turn ON Bluetooth", message: "To use EsLight you need to turn on Bluetooth in your phone")
        }
    }
    
}

// MARK: - Setup

@available(iOS 13.0, *)
private extension ViewController {
    
    func setupView() {
        
        addViews()
        addActions()
        
        setupOnButton()
    }
    
}

// MARK: - Setups View

@available(iOS 13.0, *)
private extension ViewController {
    
    func addViews() {
        
    }
    
    func addActions() {
      
    }
    
    func setupOnButton() {
       
    }
    
}

// MARK: - Layout

@available(iOS 13.0, *)
private extension ViewController {
    
    func layout() {
        
    }
    
}

// MARK: - Constants

@available(iOS 13.0, *)
private extension ViewController {
    
   
    
}
