//
//  ViewController.swift
//  iOSStoryboardsAndUIElements
//
//  Created by Radi on 30.12.22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var calculatorWorkings: UILabel!
    @IBOutlet weak var calculatorResult: UILabel!
    
    var workings: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allClear()
    }
    
    func allClear() {
        workings = ""
        calculatorResult.text = ""
        calculatorWorkings.text = ""
    }
    
    func equalTap() {
        if validInput() {
            let exression = NSExpression(format: workings )
            let result = (exression.expressionValue(with: nil, context: nil) as! Double)
            let resultString = formatResult(result: result)
            calculatorResult .text = resultString
        } else {
            let alert = UIAlertController(title: "invalid input", message: "Calculator unable to do math based on input", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title:  "Okay", style: .default))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    
    func validInput() -> Bool {
        var count = 0
        var funcCharIndexes = [Int]()
        
        for char in workings {
            if specialCharacter(char: char) {
                funcCharIndexes.append(count)
            }
            count += 1
        }
        
        var previous: Int = -1
        
        for index in funcCharIndexes {
            if index == 0 {
                return false
            }
            
            if index == workings.count - 1 {
                return false
            }
            
            if previous != -1 {
                if index - previous == 1 {
                    return false
                }
            }
            
            previous = index
        }
        
        return true
    }
    
    func specialCharacter(char: Character) -> Bool {
        
        if char == "*" {
            return true
        }
        
        if char == "/" {
            return true
        }
        
        if char == "+" {
            return true
        }
        
        return false
    }
    
    func formatResult(result: Double) -> String {
        if result.truncatingRemainder(dividingBy: 1) == 0 {
            return String(format: "%.0f", result)
        } else {
            return String(format: "%.2f", result)
        }
    }
    
    func backTapped() {
        if !workings.isEmpty {
            workings.removeLast()
            calculatorWorkings.text = workings
        }
    }
    
    func addToWorkings(value: String) {
        workings = workings + value
        calculatorWorkings.text = workings
    }
    
    
    
    @IBAction func tappedButton(_ sender: UIButton) {
        guard let input = sender.titleLabel?.text else {
            return
        }
        
        switch input {
        case "AC":
            allClear()
        case "⌫":
            backTapped()
        case "=":
            equalTap()
        default:
            addToWorkings(value: input)
        }
    }
}
