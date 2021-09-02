//
//  CalculatorErrorDelegate.swift
//  CountOnMe
//
//  Created by Square on 10/08/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import Foundation

// Will show pop up Alert message

    internal protocol CalculatorDisplay: AnyObject {
    func updateCalculeText(calculeText: String)
    func showAlert(message: String)
}
