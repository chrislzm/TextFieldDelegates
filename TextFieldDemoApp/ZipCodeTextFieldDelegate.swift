//
//  ZipCodeFieldDelegate.swift
//  TextFieldDemoApp
//
//  Created by Chris Leung on 3/21/17.
//  Copyright © 2017 Chris Leung. All rights reserved.
//

import Foundation
import UIKit

class ZipCodeTextFieldDelegate : NSObject, UITextFieldDelegate {
    
    func containsOnlyNumbers(_ string: String) -> Bool {
        let numbers = "0123456789"
        for char in string.characters {
            if !numbers.contains(String(char)) {
                return false
            }
        }
        return true
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        // As long as the replacement string contains only numbers
        if !containsOnlyNumbers(string) {
            return false
        }
        
        // And it doesn't make the text field longer than 5 numbers
        if (textField.text?.characters.count)! + string.characters.count > 5 {
            return false
        }
        
        // Then we'll accept it!
        return true
    }
}
