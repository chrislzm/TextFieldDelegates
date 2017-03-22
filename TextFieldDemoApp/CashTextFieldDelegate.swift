//
//  CashTextFieldDelegate.swift
//  TextFieldDemoApp
//
//  Created by Chris Leung on 3/21/17.
//  Copyright © 2017 Chris Leung. All rights reserved.
//

import Foundation
import UIKit

class CashTextFieldDelegate : NSObject, UITextFieldDelegate {
    
    func containsOnlyMoneySymbols(_ string: String) -> Bool {
        let moneySymbols = "0123456789$.,"
        for char in string.characters {
            if !moneySymbols.contains(String(char)) {
                return false
            }
        }
        return true
    }

    func moneyFormat(_ string: String) -> String {
        let numbers = "0123456789"
        var numbersOnly = String()
        
        // Remove dollar sign, periods and commas
        for char in string.characters {
            if numbers.contains(String(char)) {
                numbersOnly.append(char)
            }
        }
        
        // Remove leading 0's
        var leadingZerosFound = 0
        
        for char in numbersOnly.characters {
            if char == "0" {
                leadingZerosFound += 1
            } else {
                break
            }
        }
        
        let index = numbersOnly.index(numbersOnly.startIndex, offsetBy: leadingZerosFound)
        let cents = numbersOnly.substring(from: index)
        let digits = cents.characters.count
        
        var dollars = cents
        
        // If we have more than 5 digits, insert commas at the proper locations
        if digits > 5 {
            var insertPosition = 5
            while insertPosition < dollars.characters.count {
                dollars.insert(",", at: dollars.index(dollars.endIndex, offsetBy: -1*insertPosition))
                insertPosition += 4
            }
        }
            
        // If we have 2 digits or less, then add leading zeros
        else if digits <= 2 {
            for _ in 1...3-digits {
                dollars = "0" + dollars
            }
        }
        
        
        // Insert period and dollar signs at correct positions
        dollars.insert(".", at: dollars.index(dollars.endIndex, offsetBy: -2))
        dollars.insert("$", at: dollars.startIndex)
     
        return dollars
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // Get the resulting string
        let text = textField.text! as NSString
        let newString = text.replacingCharacters(in: range, with: string) as String
        
        // Make sure the resulting string contains only money symbols
        if !containsOnlyMoneySymbols(newString) {
            return false
        }
        
        // Create our own custom string based on the resulting string
        textField.text = moneyFormat(newString)
        
        // Don't accept the proposed change, as we've formatted it the way we want it already
        return false
    }
}
