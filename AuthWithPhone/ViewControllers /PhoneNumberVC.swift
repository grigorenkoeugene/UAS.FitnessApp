//
//  PhoneNumberVC.swift
//  AuthWithPhone
//
//  Created by Admin on 30/11/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import FlagPhoneNumber
import FirebaseAuth
import Firebase

class PhoneNumberVC: UIViewController {
    
    var phoneNumber: String?

    @IBOutlet weak var PhoneNamberTextField: FPNTextField!
    @IBOutlet weak var fetchCodeButton: UIButton!
    
    @IBAction func fetchCodeTapped(_ sender: UIButton) {
        guard phoneNumber != nil else {return}
        Auth.auth().languageCode = "ru"
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber!, uiDelegate: nil){
            (verificationID, error) in
            if error != nil {
                print(error?.localizedDescription ?? "is empty")
            } else {
                self.showCodeValid(verificationID: verificationID! )
            }
        }
    }
    
    private func showCodeValid(verificationID: String){
        let storybord = UIStoryboard(name: "Main", bundle: nil)
        let dvc = storybord.instantiateViewController(withIdentifier: "CodeValidVC") as!
            CodeValidVC
        dvc.verificationID = verificationID
        self.present(dvc, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setapConfig()
    }
    
    private func setapConfig() {
        fetchCodeButton.alpha = 0.5
        fetchCodeButton.isEnabled = false
        
        PhoneNamberTextField.delegate = self
        PhoneNamberTextField.setCountries(including: [.BY])
        PhoneNamberTextField.flagButton.isUserInteractionEnabled  =  false
    }
    
  
 

}

extension PhoneNumberVC: FPNTextFieldDelegate {
    
    func fpnDidValidatePhoneNumber(textField: FPNTextField, isValid: Bool) {
    if isValid {
            fetchCodeButton.alpha = 1
            fetchCodeButton.isEnabled = true

        phoneNumber = textField.getFormattedPhoneNumber(format: .International )
        } else {
        fetchCodeButton.alpha = 0.5
            fetchCodeButton.isEnabled = false
        }
    }
    
    func fpnDidSelectCountry(name: String, dialCode: String, code: String) {
        ///
    }
    func fpnDisplayCountryList() {
        ///
    }
}
    


