//
//  ViewController.swift
//  ClevelandClinicTest
//
//  Created by Manish Reddy on 12/15/16.
//  Copyright © 2016 Manish. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var dateOfBirth: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstName.delegate = self
        lastName.delegate = self
        dateOfBirth.delegate = self
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
       
        if textField.tag < 3  {
            let invalidCharacters = CharacterSet(charactersIn: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz`,.'\"- ").inverted
            return string.rangeOfCharacter(from: invalidCharacters, options: [], range: string.startIndex ..< string.endIndex) == nil
        } else {
            let invalidCharacters = CharacterSet(charactersIn: "1234567890\\/").inverted
            return string.rangeOfCharacter(from: invalidCharacters, options: [], range: string.startIndex ..< string.endIndex) == nil
        }
    }
    
   //Submit Button Action
    @IBAction func submitButton(_ sender: Any) {
        
        if let fname = firstName.text, let lname = lastName.text, let dob = dateOfBirth.text {
            Networking.sharedInstance.postPatientData(firstName: fname, lastName: lname, dateOfBirth: dob) { result in
                if result {
                    //Show alert if success
                    self.showCheckedInAlert()
                }
            }
        }
    }
    
    //Show Patient Checked in alert.
    func showCheckedInAlert() {
        let successAlert = UIAlertController(title: "Success", message:
            "Patient has been checked in ", preferredStyle: UIAlertControllerStyle.alert)
        successAlert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
        self.present(successAlert, animated: true, completion: nil)
    }
    
}
