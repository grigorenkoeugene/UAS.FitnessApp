//
//  ViewController.swift
//  AuthWithPhone
//
//  Created by Admin on 17/11/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import FirebaseAuth


class AuthVC: UIViewController {

    @IBAction func closeSegue(_ sender: UIStoryboardSegue) {
        
    }
    
    @IBAction func authTapped() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let dvc = storyboard.instantiateViewController(withIdentifier: "PhoneNamberVC") as! PhoneNamberVC
        self.present(dvc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        DispatchQueue.main.async {
            if Auth.auth().currentUser?.uid != nil {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let dvc = storyboard.instantiateViewController(withIdentifier: "ContentVC") as! ContentVC
                self.present(dvc, animated: true, completion: nil)
            }
        }
    }


}

