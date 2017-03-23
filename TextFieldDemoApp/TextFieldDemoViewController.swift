//
//  ViewController.swift
//  TextFieldDemoApp
//
//  Created by Chris Leung on 3/21/17.
//  Copyright © 2017 Chris Leung. All rights reserved.
//

import UIKit

class TextFieldDemoViewController: UIViewController, UITextFieldDelegate {

    // MARK: Outlets
    @IBOutlet weak var zipCodeTextField: UITextField!
    @IBOutlet weak var cashTextField: UITextField!
    @IBOutlet weak var lockableTextField: UITextField!

    // MARK: Text Field Delegate objects
    let zipCodeDelegate = ZipCodeTextFieldDelegate()
    let cashDelegate = CashTextFieldDelegate()
    //let cashDelegate =  AlternateCashTextFieldDelegate()
    
    // MARK: Other properties
    var locked = true // Assumes switch has been set to on in storyboard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.zipCodeTextField.delegate = zipCodeDelegate
        self.cashTextField.delegate = cashDelegate
        self.lockableTextField.delegate = self
    }
    
    @IBAction func toggleLock(_ sender: AnyObject) {
        let theSwitch = sender as! UISwitch
        locked = theSwitch.isOn
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if locked {
            return true
        }
        return false
    }

}

