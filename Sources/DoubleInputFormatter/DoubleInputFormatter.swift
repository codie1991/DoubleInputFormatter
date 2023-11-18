//
//  DoubleInputFormatter.swift
//
//
//  Created by Codie Westphall on 3/11/23.
//

import UIKit

class DoubleInputFormatter {
    
    /// The number formatter we'll apply to generate the formatted string
    ///
    /// Defaults to a `.currency` number style.
    /// Override to have more control of the formatted string
    var numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }()
    
    /// The current inputs value as a Double if it exists
    private(set) var amountAsDouble: Double = 0.0
    
    /// Used to determine how backspace works in currencies like ¥
    private var isSymbolOnRight = false
    
    /// Register for updates to the value of the textField input converted to
    var valueForInput: ((Double) -> Void)?
    
    
    func detectSymbolOnBackspace(text: String, newInput: String) {
        let lastCharacterInText = (text).last
        // when newInput is a blank string, Backspace was pressend
        if newInput == "" && lastCharacterInText?.isNumber == false {
            //For hitting backspace and currency is on the right side
            isSymbolOnRight = true
        } else {
            isSymbolOnRight = false
        }
    }
    
    /// Updates the textField with the formatted string
    ///
    /// Using the `textField.text` as input storage,
    /// sanitise the string for only numerical values
    /// create a `Double` amount from the sanitised text
    /// that double is used to set a newly formatted string on the `textField`
    func update(_ textField: UITextField) {
        var sanitisedAmount = ""
        
        for character in textField.text ?? "" {
            if character.isNumber {
                sanitisedAmount.append(character)
            }
        }
        
        // Support for both right and left currencies
        if isSymbolOnRight {
            // The Symbol was deleted in the textField.text storage
            // so we instead drop another character which is the
            // intended currency value to be deleted.
            // The currency symbol will be re-added via formatter
            sanitisedAmount = String(sanitisedAmount.dropLast())
        }
        
        //Format the number based on number of decimal digits
        if numberFormatter.maximumFractionDigits > 0 {
            //ie. USD
            let amount = Double(sanitisedAmount) ?? 0.0
            amountAsDouble = (amount / 100.0)
        } else {
            //ie. JPY
            let amountAsNumber = Double(sanitisedAmount) ?? 0.0
            amountAsDouble = amountAsNumber
        }
        
        let stringifyValue = NSNumber(value: amountAsDouble)
        let amountAsString = numberFormatter.string(from: stringifyValue) ?? ""
        
        // Set a placeholder when textAlignment is set to `.right`.
        // The text cursor sit's in the incorrect location for `.left`
        if stringifyValue.isEqual(to: 0) && textField.textAlignment == .right {
            textField.text = nil
            textField.placeholder = amountAsString
        } else {
            textField.text = amountAsString
        }
        
        // update listeners to the double value
        valueForInput?(amountAsDouble)
    }
    
}
