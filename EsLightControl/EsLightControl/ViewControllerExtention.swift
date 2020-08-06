//
//  ViewControllerExtention.swift
//  EsLightControl
//
//  Created by Yura Menschikov on 6/16/20.
//  Copyright © 2020 Yura Menschikov. All rights reserved.
//

import Foundation
import UIKit
@available (iOS 13.0, *)


extension ViewController {
    
    //MARK: Create Buttons
    func createButtons(color: UIColor, title: String, action: Selector) -> UIButton {
        
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.lightGray, for: .highlighted)
        button.backgroundColor = color
        button.widthAnchor.constraint(equalToConstant: 100).isActive = true
        button.heightAnchor.constraint(equalToConstant: 100).isActive = true
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.addTarget(self, action: action, for: .touchUpInside)
        
        return button
    }
     
     
    //MARK: Create SegmentControllers
    func createSegments(item: [String], x: Int, y: Int, width: Int, color: UIColor, target: Selector) -> UISegmentedControl {
        
        var segment = UISegmentedControl()
        
        segment = UISegmentedControl(items: item)
        segment.backgroundColor = color
        segment.frame = CGRect(x: x, y: y, width: width, height: 100)
        segment.selectedSegmentTintColor = UIColor(red: (224/255.0), green: (226/255.0), blue: (210/255.0), alpha: 1.0)
        segment.setTitleTextAttributes(titleTextAttributes, for: .selected)
        segment.setTitleTextAttributes([NSAttributedString.Key.font: segmentFont], for: .normal)
        segment.setTitleTextAttributes([NSAttributedString.Key.font: segmentFont], for: .highlighted)
        segment.addTarget(self, action: target, for: .valueChanged)
        
        self.view.addSubview(segment)
        return segment
    }
    
     
    
    //MARK: Create Stuff
    @objc func createStuff() {
        self.view.backgroundColor = UIColor(red: (238/255.0), green: (238/255.0), blue: (238/255.0), alpha: 1.0)
        self.title = "EsLight"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Settings", style: .plain, target: self, action: #selector(pressToSettings(sender:)))
        navigationController?.navigationBar.tintColor = UIColor.black
        
    }
    
    //MARK: Functions to pressed buttons
    
    @objc func firstGroupFunc() {
        let segmentIndex = group1.selectedSegmentIndex
        switch segmentIndex {
        case 0:
            g1off()
        case 1:
            g1on()
        default:
            break
            }
        }
    
    @objc func secondGroupFunc() {
    let segmentIndex = group2.selectedSegmentIndex
    switch segmentIndex {
    case 0:
        g2off()
    case 1:
        g2on()
    default:
        break
        }
    }
    
    @objc func thirdGroupFunc() {
    let segmentIndex = group3.selectedSegmentIndex
    switch segmentIndex {
    case 0:
        g3off()
    case 1:
        g3on()
    default:
        break
        }
    }
    
    @objc func fourthGroupFunc() {
    let segmentIndex = group4.selectedSegmentIndex
    switch segmentIndex {
    case 0:
        g4off()
    case 1:
        g4on()
    default:
        break
        }
    }
    
    @objc func percentGroupFunc() {
    let segmentIndex = percentGroup.selectedSegmentIndex
    switch segmentIndex {
    case 0:
        b25()
    case 1:
        b50()
    case 2:
        b75()
    default:
        break
        }
    }
    
    
    
       @objc func onButtonPressed() {
        group1.selectedSegmentIndex = 1
        group2.selectedSegmentIndex = 1
        group3.selectedSegmentIndex = 1
        group4.selectedSegmentIndex = 1
           serial.delegate = self
           data = "A"
           serial.sendMessageToDevice(data)
        print("A")
       }
       
       @objc func offButtonPressed() {
        group1.selectedSegmentIndex = 0
        group2.selectedSegmentIndex = 0
        group3.selectedSegmentIndex = 0
        group4.selectedSegmentIndex = 0
        percentGroup.selectedSegmentIndex = 0
           serial.delegate = self
           data = "B"
           serial.sendMessageToDevice(data)
        print("B")
       }
       
       @objc func g1on() {
           serial.delegate = self
           data = "T"
           serial.sendMessageToDevice(data)
        print("g1on")
       }
    
       @objc func g1off() {
           serial.delegate = self
           data = "G"
           serial.sendMessageToDevice(data)
        print("g1off")
       }
    
       @objc func g2on() {
           serial.delegate = self
           data = "Y"
           serial.sendMessageToDevice(data)
        print("g2on")
       }
    
       @objc func g2off() {
           serial.delegate = self
           data = "H"
           serial.sendMessageToDevice(data)
        print("g2off")
       }
    
       @objc func g3on() {
           serial.delegate = self
           data = "U"
           serial.sendMessageToDevice(data)
        print("g3on")
       }
    
       @objc func g3off() {
           serial.delegate = self
           data = "J"
           serial.sendMessageToDevice(data)
        print("g3off")
       }
    
    @objc func g4on() {
           serial.delegate = self
           data = "I"
           serial.sendMessageToDevice(data)
        print("g4on")
       }
    
    @objc func g4off() {
           serial.delegate = self
           data = "K"
           serial.sendMessageToDevice(data)
        print("g4off")
       }
       
       @objc func b25() {
           serial.delegate = self
           data = "M"
           serial.sendMessageToDevice(data)
        print("25%")
       }
    
       @objc func b50() {
           serial.delegate = self
           data = "N"
           serial.sendMessageToDevice(data)
        print("50%")
       }
    
       @objc func b75() {
           serial.delegate = self
           data = "L"
           serial.sendMessageToDevice(data)
        print("75%")
       }
}
