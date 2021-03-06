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

/// The option to add a \n or \r or \r\n to the end of the send message
enum MessageOption: Int {
    case noLineEnding,
         newline,
         carriageReturn,
         carriageReturnAndNewline
}

/// The option to add a \n to the end of the received message (to make it more readable)
enum ReceivedMessageOption: Int {
    case none,
         newline
}
@available (iOS 13.0, *)
final class ViewController: UIViewController, UITextFieldDelegate, BluetoothSerialDelegate {
    
    //MARK: Init subjects
    var OnButton = UIButton()
    var OffButton = UIButton()
    var group1 = UISegmentedControl()
    var group2 = UISegmentedControl()
    var group3 = UISegmentedControl()
    var group4 = UISegmentedControl()
    var percentGroup = UISegmentedControl()
    
    var segment = UISegmentedControl()
    
    var data: String = ""
    var segmentArrayONOFF = ["OFF","ON"]
    var segmentArray255075 = ["25%","50%","75%"]
    let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
    let segmentFont = UIFont.boldSystemFont(ofSize: 14)
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        serial = BluetoothSerial(delegate: self)
        
        reloadView()
        createStuff()
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.reloadView), name: NSNotification.Name(rawValue: "reloadStartViewController"), object: nil)
        
        OnButton = createButtons(color: UIColor(red: (180/255.0), green: (197/255.0), blue: (64/255.0), alpha: 1.0), title: "ON", action: #selector(onButtonPressed))
        view.addSubview(OnButton)
        OnButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 80).isActive = true
        OnButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100).isActive = true
        
        OffButton = createButtons(color: UIColor(red: (198/255.0), green: (64/255.0), blue: (64/255.0), alpha: 1.0), title: "OFF", action: #selector(offButtonPressed))
        view.addSubview(OffButton)
        OffButton.leftAnchor.constraint(equalTo: OnButton.leftAnchor, constant: 150).isActive = true
        OffButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100).isActive = true
        
        
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
    
    //MARK: UI
    @objc func reloadView() {
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
    @objc func pressToSettings(sender: UITextField) {
        let settings = SettingsViewController()
        self.navigationController?.pushViewController(settings, animated: true)
    }
    
    @objc func pressToConnect(sender: UITextField) {
        let connect = ConnectViewController()
        self.navigationController?.pushViewController(connect, animated: true)
    }
    
    //MARK: BluetoothSerialDelegate
    func serialDidDisconnect(_ peripheral: CBPeripheral, error: NSError?) {
        reloadView()
        let someAction = UIAlertController(title: "Disconnected", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default) { (action) in
        }
        someAction.addAction(action)
        self.present(someAction, animated: true, completion: nil)
    }
    
    func serialDidChangeState() {
        reloadView()
        if serial.centralManager.state != .poweredOn {
            let someAction = UIAlertController(title: "Turn ON Bluetooth", message: "To use EsLight you need to turn on Bluetooth in your phone", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default) { (action) in
            }
            someAction.addAction(action)
            self.present(someAction, animated: true, completion: nil)
        }
    }
    
}
