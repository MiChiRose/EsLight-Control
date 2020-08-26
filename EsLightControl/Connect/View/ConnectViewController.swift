//
//  ConnectViewController.swift
//  EsLight
//
//  Created by Yura Menschikov on 6/16/20.
//  Copyright © 2020 Yura Menschikov. All rights reserved.
//

import UIKit
import CoreBluetooth

final class ConnectViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, BluetoothSerialDelegate {
    
    //MARK: Variables

    /// The peripherals that have been discovered (no duplicates and sorted by asc RSSI)
    var peripherals: [(peripheral: CBPeripheral, RSSI: Float)] = []

    /// The peripheral the user has selected
    var selectedPeripheral: CBPeripheral?
    
    var tableView = UITableView()
    
    var tableViewCell = "Cell"
    //var allItem = ["EsLight Control Device"]
    
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        serial.delegate = self
        
        createStuffConnectController()
        
    }
    
    //MARK: Functions
    @objc func createStuffConnectController() {
        self.title = "Devices"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(goBackButton(_:)))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Search", style: .done, target: self, action: #selector(tryAgain(_:)))
        
        self.tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.backgroundColor = UIColor(red: (33/255.0), green: (33/255.0), blue: (33/255.0), alpha: 1.0)
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: tableViewCell)
        
        if serial.centralManager.state != .poweredOn {
            title = "Bluetooth not turned on"
            return
        }
        view.addSubview(tableView)
    }
    
    @objc func scanTimeOut() {
        // timeout has occurred, stop scanning and give the user the option to try again
        serial.stopScan()
        title = "Done scanning"
    }
    
    @objc func connectTimeOut() {
        
        // don't if we've already connected
        if let _ = serial.connectedPeripheral {
            return
        }
        
        if let _ = selectedPeripheral {
            serial.disconnect()
            selectedPeripheral = nil
        }
        
         let someAction = UIAlertController(title: "Failed to connect", message: "Check all devices and try again", preferredStyle: .alert)
         let action = UIAlertAction(title: "Ok", style: .default) { (action) in
         }
         someAction.addAction(action)
         self.present(someAction, animated: true, completion: nil)
         
    }
    
    //MARK: Button Functions
    @objc func goBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func cancel(_ sender: AnyObject) {
        // go back
        serial.stopScan()
        dismiss(animated: true, completion: nil)
    }
    
    @objc func tryAgain(_ sender: AnyObject) {
        // empty array an start again
        peripherals = []
        tableView.reloadData()
        title = "Scanning ..."
        serial.startScan()
        Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(ConnectViewController.scanTimeOut), userInfo: nil, repeats: false)
    }
    
    //MARK: UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peripherals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let allItem = ["\(serial.connectedPeripheral?.name ?? "EsLight Control Device")"]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCell, for: indexPath)
        let item = allItem[indexPath.row]
        cell.textLabel?.text = item
        cell.backgroundColor = UIColor.gray
        return cell
    }
    
    //MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        // the user has selected a peripheral, so stop scanning and proceed to the next view
        serial.stopScan()
        selectedPeripheral = peripherals[(indexPath as NSIndexPath).row].peripheral
        serial.connectToPeripheral(selectedPeripheral!)
        
        // TODO: Timer doesn't use connecting ID
        Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(ConnectViewController.connectTimeOut), userInfo: nil, repeats: false)
    }
    
    //MARK: BluetoothSerialDelegate
    
    func serialDidDiscoverPeripheral(_ peripheral: CBPeripheral, RSSI: NSNumber?) {
        // check whether it is a duplicate
        for exisiting in peripherals {
            if exisiting.peripheral.identifier == peripheral.identifier { return }
        }
        
        // add to the array, next sort & reload
        let theRSSI = RSSI?.floatValue ?? 0.0
        peripherals.append((peripheral: peripheral, RSSI: theRSSI))
        peripherals.sort { $0.RSSI < $1.RSSI }
        tableView.reloadData()
    }
    
    func serialDidFailToConnect(_ peripheral: CBPeripheral, error: NSError?) {
        let someAction = UIAlertController(title: "Failed to connect", message: "Check all devices and try again", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default) { (action) in
        }
        someAction.addAction(action)
        self.present(someAction, animated: true, completion: nil)
    }
    
    func serialIsReady(_ peripheral: CBPeripheral) {
        let someAction = UIAlertController(title: "Device is ready", message: "connected", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default) { (action) in
            self.goBackButton(self)
        }
        someAction.addAction(action)
        self.present(someAction, animated: true, completion: nil)
    }
    
    func serialDidChangeState() {
        let someAction = UIAlertController(title: "Device change", message: "device was changed", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default) { (action) in
        }
        someAction.addAction(action)
        self.present(someAction, animated: true, completion: nil)
    }
    
    func serialDidDisconnect(_ peripheral: CBPeripheral, error: NSError?) {
        let someAction = UIAlertController(title: "Disconnected", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default) { (action) in
        }
        someAction.addAction(action)
        self.present(someAction, animated: true, completion: nil)
    }
    
}
