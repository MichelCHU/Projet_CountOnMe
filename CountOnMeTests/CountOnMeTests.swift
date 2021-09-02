//
//  CountOnMeTests.swift
//  CountOnMeTests
//
//  Created by Square on 28/07/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

class CountOnMeTests: XCTestCase {
    
    var calculator: Calculator!
    
    override func setUp() {
        super.setUp()
        
        calculator = Calculator()
    }
    
    override func tearDown() {
        calculator = nil
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    //MARK:- Check Number button and Calcul
    
    func testCalculeMethod_WhenExpressionHaveEnoughElement_ThenShouldReturnCorrectResult() {
        calculator.tappedNumberButton(numberText: "1")
        calculator.tappedOperator(with: "+")
        calculator.calculate()
        
        XCTAssertEqual(calculator.textToCompute, "1 + ")
    }
    
    func testCalculeMethod_WhenexpressionHaveResult_ThenShouldReturnCorrectResult() {
        calculator.tappedNumberButton(numberText: "1")
        calculator.tappedOperator(with: "+")
        calculator.tappedNumberButton(numberText: "1")
        calculator.tappedOperator(with: "=")
        calculator.tappedNumberButton(numberText: "5")
        
        XCTAssertNotEqual(calculator.textToCompute, "1 + 1 = 5")
    }
    
    func testTappedButton_WhenCorrectTappedNumberPassed_ThenShouldReturnCorrectResult() {
        calculator.tappedNumberButton(numberText: "2")
        
        XCTAssertEqual(calculator.textToCompute, "2")
    }
    
    func testCalculeMethod_WhenCorrectAdditionIsPassed_ThenShouldReturnCorrectResult() {
        calculator.tappedNumberButton(numberText: "1")
        calculator.tappedOperator(with: "+")
        calculator.tappedNumberButton(numberText: "1")
        calculator.calculate()
        
        XCTAssertEqual(calculator.textToCompute, "1 + 1 = 2")
    }
    
    func testCalculeMethod_WhenCorrectSubstractionIsPassed_ThenShouldReturnCorrectResult() {
        calculator.tappedNumberButton(numberText: "2")
        calculator.tappedOperator(with: "-")
        calculator.tappedNumberButton(numberText: "5")
        calculator.calculate()
        
        XCTAssertEqual(calculator.textToCompute, "2 - 5 = -3")
    }
    
    func testCalculeMethod_WhenCorrectMultiplicationIsPassed_ThenShouldReturnCorrectResult() {
        calculator.tappedNumberButton(numberText: "2")
        calculator.tappedOperator(with: "x")
        calculator.tappedNumberButton(numberText: "5")
        calculator.calculate()
        
        XCTAssertEqual(calculator.textToCompute, "2 x 5 = 10")
    }
    
    func testCalculeMethod_WhenCorrectDiviseIsPassed_ThenShouldReturnCorrectResult() {
        calculator.tappedNumberButton(numberText: "2")
        calculator.tappedOperator(with: "÷")
        calculator.tappedNumberButton(numberText: "5")
        calculator.calculate()
        
        XCTAssertEqual(calculator.textToCompute, "2 ÷ 5 = 0.4")
    }
    
    func testCalculeMethod_WhenCorrectPriorityCalculIsPassed_ThenShouldReturnCorrectResult() {
        calculator.tappedNumberButton(numberText: "2")
        calculator.tappedOperator(with: "÷")
        calculator.tappedNumberButton(numberText: "5")
        calculator.tappedOperator(with: "x")
        calculator.tappedNumberButton(numberText: "5")
        calculator.tappedOperator(with: "+")
        calculator.tappedNumberButton(numberText: "8")
        calculator.calculate()
        
        XCTAssertEqual(calculator.textToCompute, "2 ÷ 5 x 5 + 8 = 10")
    }
    
    // MARK:- Testing Equal Button
    
    func testGivinAnIncorrectExpression_WhenTriggeringFunc_ThenExpressionGetResult() {
        calculator.tappedNumberButton(numberText: "5")
        calculator.tappedOperator(with: "x")
        calculator.tappedNumberButton(numberText: "5")
        calculator.tappedOperator(with: "+")
        calculator.calculate()
        
        XCTAssertTrue(calculator.textToCompute == "5 x 5 + ")
    }
    
    func testGivinLastElementIsOperand_WhenTrggeringfunc_ThenElementsDoesntChange() {
        calculator.tappedNumberButton(numberText: "5")
        calculator.tappedOperator(with: "x")
        calculator.calculate()
        
        XCTAssertTrue(calculator.textToCompute == "5 x ")
    }
    
    // MARK: - CHECK ERROR OPERATOR
    
    func testGivenFirstIndexBeforeNumber_WhenScreenDisplayError_ThenScreenDisplayError() {
        calculator.tappedOperator(with: "x")
        calculator.tappedNumberButton(numberText: "2")
        calculator.tappedOperator(with: "x")
        calculator.tappedNumberButton(numberText: "2")
        calculator.calculate()
        
        
        XCTAssertEqual(calculator.textToCompute, "2 x 2 = 4")
    }
    
    func testGivenAdditionOperator_WhenScreenDisplayError_ThenScreenDisplayError() {
        calculator.tappedNumberButton(numberText: "2")
        calculator.tappedOperator(with: "+")
        calculator.tappedOperator(with: "+")
        
        XCTAssertEqual(calculator.textToCompute, "2 + ")
    }
    
    func testGivenSubstractionOperator_WhenScreenDisplayError_ThenScreenDisplayError() {
        calculator.tappedNumberButton(numberText: "2")
        calculator.tappedOperator(with: "-")
        calculator.tappedOperator(with: "-")
        
        XCTAssertEqual(calculator.textToCompute, "2 - ")
    }
    
    func testGivenMultiplcationOperator_WhenScreenDisplayError_ThenScreenDisplayError() {
        calculator.tappedNumberButton(numberText: "2")
        calculator.tappedOperator(with: "x")
        calculator.tappedOperator(with: "x")
        
        XCTAssertEqual(calculator.textToCompute, "2 x ")
    }
    
    func testGivenDiviseOperator_WhenScreenDisplayError_ThenScreenDisplayError() {
        calculator.tappedNumberButton(numberText: "2")
        calculator.tappedOperator(with: "+")
        calculator.tappedOperator(with: "+")
        
        XCTAssertEqual(calculator.textToCompute, "2 + ")
    }
    
    func testGivenEqualEqual_WhenScreenDisplayError_ThenScreenDisplayError() {
        calculator.tappedOperator(with: "=")
        calculator.tappedOperator(with: "=")
        
        XCTAssertEqual(calculator.textToCompute, "")
    }
    
    //MARK: - Divide By ZERO
    
    func testCalculeMethodDivideOperator_WhenScreenDisplayCantCalculate_ThenScreenDisplayError() {
        calculator.tappedNumberButton(numberText: "2")
        calculator.tappedOperator(with: "÷")
        calculator.tappedNumberButton(numberText: "0")
        calculator.calculate()
        
        XCTAssertEqual(calculator.textToCompute, "2 ÷ 0")
    }
    
    // MARK: - RESET BUTTON
    func testGivenAnExpression_WhenTriggeringFunctionReset_ThenElementIsEmpty() {
        calculator.tappedNumberButton(numberText: "2")
        calculator.buttonAC()
        
        XCTAssert(calculator.textToCompute.isEmpty)
    }
    
    func testGivenAnExpression_WhenTriggeringFunctionReset2_ThenElementIsEmpty() {
        calculator.tappedNumberButton(numberText: "2")
        calculator.buttonAC()
        
        XCTAssertEqual(calculator.textToCompute, "")
    }
}
