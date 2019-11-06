//
//  SingleContactViewController.swift
//  Core Data
//
//  Created by Joshua Brooks on 11/4/19.
//  Copyright © 2019 Joshua Brooks. All rights reserved.
//

import UIKit

class SingleContactViewController: UIViewController {

    @IBOutlet weak var firstTextField: UITextField!
    @IBOutlet weak var lastTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    
    var existingContact: Contact?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        firstTextField.text = existingContact?.first
        lastTextField.text = existingContact?.last
        emailTextField.text = existingContact?.email
        phoneTextField.text = existingContact?.phone
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        firstTextField.resignFirstResponder()
        lastTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        phoneTextField.resignFirstResponder()
    }
    
    @IBAction func saveContact(_ sender: Any) {
        let first = firstTextField.text
        let last = lastTextField.text
        let email = emailTextField.text
        let phone = phoneTextField.text
        
        var contact: Contact?
        
        if let existingContact = existingContact {
            existingContact.first = first
            existingContact.last = last
            existingContact.email = email
            existingContact.phone = phone
            
            contact = existingContact
        } else {
            contact = Contact(first: first, last: last, email: email, phone: phone)
        }
        
        if let contact = contact {
            do {
                let managedContext = contact.managedObjectContext
                
                try managedContext?.save()
                
                self.navigationController?.popViewController(animated: true)
            } catch {
                print("Context could not be saved")
            }
        }
    }
}
extension SingleContactViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
