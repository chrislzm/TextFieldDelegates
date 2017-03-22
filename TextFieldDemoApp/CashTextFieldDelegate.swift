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
    
    // Returns a true if the string contains only numbers or $ , .
    func containsOnlyMoneySymbols(_ string: String) -> Bool {
        let moneySymbols = "0123456789$.,"
        for char in string.characters {
            if !moneySymbols.contains(String(char)) {
                return false
            }
        }
        return true
    }

    // Extracts numbers from a string and returns it string formatted in US currency
    func formatInUSCurrency(_ string: String) -> String {
        let numbers = "0123456789"
        var numbersOnly = String()
        
        // Remove dollar sign, periods and commas
        for char in string.characters {
            if numbers.contains(String(char)) {
                numbersOnly.append(char)
            }
        }
        
        // Get total cents by counting leading 0's (if any) and extracting the substring
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

        // Will store final formatted string
        var dollars = cents
        
        // If cents occupy more than 5 digits, we need to insert commas
        if digits > 5 {
            // Set insert position initally at the $1,000.00 mark
            var insertPosition = 5
            
            // While we still have space left to insert commas
            while insertPosition < dollars.characters.count {
                dollars.insert(",", at: dollars.index(dollars.endIndex, offsetBy: -1*insertPosition))
                
                // Increment by 4 since we are skipping 3 digits AND a comma
                insertPosition += 4
            }
        }
        // Otherwise, if cents occupy 2 digits or less, then add leading zeroes as needed
        else if digits <= 2 {
            for _ in 1...3-digits {
                dollars = "0" + dollars
            }
        }
        
        // Finally, insert period and dollar signs at correct positions
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
        textField.text = formatInUSCurrency(newString)
        
        // Don't accept the proposed change, as we've formatted it the way we want it already
        return false
    }
}
