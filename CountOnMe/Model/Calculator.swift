//
//  Calculator.swift
//  CountOnMe
//
//  Created by Square on 28/07/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import Foundation

final class Calculator {
    
    //MARK:- Property
    
    weak var delegate: CalculatorDisplay?
    var textToCompute: String = "" {
        didSet {
            delegate?.updateCalculeText(calculeText: textToCompute)
        }
    }
    
    private var elements: [String] {
        return textToCompute.split(separator: " ").map { "\($0)" }
    }
    
    // Error check computed variables
    private var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "÷"
    }
    
    // Check if we can calculate
    private var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    
    private var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "÷"
    }
    
    // check if Operater sign is not first
    private var isStartingOperater: Bool {
        return elements.count == 0
    }
    
    private var expressionHaveResult: Bool {
        return textToCompute.firstIndex(of: "=") != nil
    }
    
    private var isDivideByZero: Bool {
        return textToCompute.contains("÷ 0")
    }
    
    //MARK:- METHODS
    
    internal func tappedNumberButton(numberText: String) {
        if expressionHaveResult {
            textToCompute = ""
        }
        textToCompute.append(numberText)
    }
    
    internal func tappedOperator(with mathOperator: String) {
        if isStartingOperater {
            delegate?.showAlert(message: "Commencer par un chiffre !")
        } else if !canAddOperator {
            delegate?.showAlert(message: "Un Opérateur est déjà mis !")
        } else {
            textToCompute.append(" \(mathOperator) ")
        }
    }
    
    // Button for do a Reset
    internal func buttonAC() {
        textToCompute.removeAll()
        delegate?.updateCalculeText(calculeText: "0")
    }
    
    // NumberFormatter will convert Double in a simple digital
    private func formatResult(_ result: Double) -> String? {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        let formatedResult = formatter.string(from: NSNumber(value: result))
        return formatedResult
    }
    
    // Priority of Calcaul "x" & "÷" before "+" & "-"
    private func priorityCalcul(elements: [String]) -> [String] {
        var expression = elements
        while expression.contains("x") || expression.contains("÷"){
            if let index = expression.firstIndex(where: { $0 == "x" || $0 == "÷" }) {
                let operand = expression[index]
                let result: Double
                if let left = Double(expression[index-1]){
                    if let right = Double(expression[index+1]){
                        if operand == "x" {
                            result = left * right
                        } else {
                            result = left / right
                        }
                        expression.remove(at: index + 1)
                        expression.remove(at: index)
                        expression.remove(at: index - 1)
                        expression.insert(String(result), at: index - 1)
                    }
                }
            }
        }
        return expression
    }
    
    internal func calculate() {
        guard expressionHaveEnoughElement else {
            delegate?.showAlert(message: "Démarrez un nouveau calcul !")
            return
        }
        guard expressionIsCorrect else {
            delegate?.showAlert(message: "Entrez une expression correcte !")
            return
        }
        guard !isDivideByZero else {
            delegate?.showAlert(message: "Impossible de diviser par 0! ")
            return
        }
        // Create local copy of operations
        var operationsToReduce = priorityCalcul(elements: elements)
        var result: Double
        
        // Iterate over operations while an operand still here
        while operationsToReduce.count > 1 {
            guard let left = Double(operationsToReduce[0]) else { return }
            let operand = operationsToReduce[1]
            guard let right = Double(operationsToReduce[2]) else { return }
            
            switch operand {
            case "+": result = left + right
            case "-": result = left - right
            default: return
            }
            operationsToReduce = Array(operationsToReduce.dropFirst(3))
            operationsToReduce.insert("\(result)", at: 0)
        }
        guard let total = operationsToReduce.first else { return }
        guard let totalDoubled = Double(total) else { return }
        guard let totalRounded = formatResult(totalDoubled) else { return }
        textToCompute.append(" = \(totalRounded)")
    }
}
