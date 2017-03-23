//
//  AlternateCashTextFieldDelegate.swift
//  TextFieldDemoApp
//
//  Created by Chris Leung on 3/22/17.
//  Copyright © 2017 Chris Leung. All rights reserved.
//

import Foundation
import UIKit

class AlternateCashTextFieldDelegate : NSObject, UITextFieldDelegate {
    
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
    func getCents(_ string: String) -> Double {
        let numbers = "0123456789"
        var centsOnly = String()
        
        // Remove dollar sign, periods and commas
        for char in string.characters {
            if numbers.contains(String(char)) {
                centsOnly.append(char)
            }
        }

        return Double(centsOnly)!/100.0
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // Get the resulting string
        let text = textField.text! as NSString
        let newString = text.replacingCharacters(in: range, with: string) as String
        
        if containsOnlyMoneySymbols(newString) {
            let cents = getCents(newString) as NSNumber
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            textField.text = formatter.string(from: cents)
        }
        
        return false
    }
}
