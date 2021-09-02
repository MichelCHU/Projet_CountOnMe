//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    
    // View Life cycles
    override internal func viewDidLoad() {
        super.viewDidLoad()
        calculator.delegate = self
        textView.text = "0"
    }
    
    // MARK: - Outlet
    @IBOutlet private weak var textView: UITextView!
    
    // MARK: - IBActions
    private let calculator = Calculator()
    
    @IBAction private func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        calculator.tappedNumberButton(numberText: numberText)
    }
    
    @IBAction private func tappedSymbolButtons(_ sender: UIButton) {
        guard let buttonTitle = sender.title(for: .normal) else { return }
        calculator.tappedOperator(with: buttonTitle)
    }
    
    @IBAction private func equalButtonTapped(_ sender: UIButton) {
        calculator.calculate()
    }
    
    @IBAction private func clear(_ sender: Any) {
        calculator.buttonAC()
    }
}

//MARK:- Extension

extension ViewController: CalculatorDisplay {
    internal func updateCalculeText(calculeText: String) {
        textView.text = calculeText
    }
    
    internal func showAlert(message: String) {
        let alertVC = UIAlertController(title: "Alert!", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}
