//
//  ContentVC.swift
//  AuthWithPhone
//
//  Created by Admin on 12/12/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import FirebaseAuth

class ContentVC: UIViewController {
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var adminButton: UIButton!
    @IBOutlet weak var airoButton: UIButton!
    @IBOutlet weak var stretchingButton: UIButton!
    @IBOutlet weak var fitnessButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let phoneNumber = Auth.auth().currentUser?.phoneNumber
        if phoneNumber == "+375445673205" {
            adminButton.alpha = 1
            label.alpha = 1
        } else {
            adminButton.alpha = 0
            label.alpha = 0
        }
    }
    
    @IBAction func airoStretchingClick(_ sender: UIButton) {
        buttonTag = sender.tag
    }
    
    @IBAction func stretchingClick(_ sender: UIButton) {
        buttonTag = sender.tag
    }
    
    @IBAction func fitnessClick(_ sender: UIButton) {
        buttonTag = sender.tag
    }
    
    func ShowTableVC(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let dvc = storyboard.instantiateViewController(withIdentifier: "TableVC") as! TableTypeTrainingsVC
        self.navigationController?.pushViewController(dvc, animated: true)
        
        self.present(dvc, animated: true)
    }
    
    @IBAction func adminButtonTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let dvc = storyboard.instantiateViewController(withIdentifier: "AdminMenuVC") as! AdminMenuVC
        self.present(dvc, animated: true)
    }
    
    
    @IBAction func logOut(_ sender: UIButton){
        do {
            try Auth.auth().signOut()
            performSegue(withIdentifier: "closeSegue", sender: self)
        } catch {
        
        }
    
}
    
}
