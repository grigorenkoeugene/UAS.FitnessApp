//
//  AdminMenuVC.swift
//  AuthWithPhone
//
//  Created by Admin on 15/12/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class AdminMenuVC: UIViewController {

    let datePicker = UIDatePicker()

    @IBOutlet weak var BackeBatton: UIButton!
    @IBOutlet weak var textFieldDirection: UITextField!
    @IBOutlet weak var textFieldCoach: UITextField!
    @IBOutlet weak var textFieldTime: UITextField!
    @IBOutlet weak var textFieldCountPeople: UITextField!
    
    @IBAction func BackeBattonTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let dvc = storyboard.instantiateViewController(withIdentifier: "ContentVC") as! ContentVC
        self.present(dvc, animated: true)
    }
    
    @IBAction func SendClickButton(_ sender: UIButton) {
        AddDataForRealm()
    }
    
    func creatDatePicker() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePressed))
        toolBar.items = [flexBarButton, doneBarButton]
        textFieldTime.inputAccessoryView = toolBar
        textFieldTime.inputView = datePicker
    }
    @objc func donePressed(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        let dataStr = dateFormatter.string(from: datePicker.date)
        textFieldTime.text = "\(dataStr)"
        self.view.endEditing(true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        textField()
        creatDatePicker()
    }
    func AddDataForRealm() {
        var textFieldCountPeopleInt = 0
        let textDirection = textFieldDirection.text
        let textCoach = textFieldCoach.text
        let textTime = textFieldTime.text
        textFieldCountPeopleInt = Int(textFieldCountPeople.text ?? "") ?? 0

        if textDirection == "" || textCoach == "" || textTime == "" || textFieldCountPeopleInt <= 0 {
            let alert = UIAlertController(title: "Ошибка", message: "Заполните все поля", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else {
            do {
                let data = Database.database().reference()
                let defaultCategories: String = textDirection!
                switch defaultCategories {
                case "Stretching":
                    let trainingData = data.child("Stretching")
                    trainingData.childByAutoId().setValue([
                        "couch": textCoach as Any,
                        "time": textTime as Any,
                        "countPeople": textFieldCountPeopleInt,
                        "users": []
                    ])
                    textFieldDirection.text?.removeAll()
                    textFieldTime.text?.removeAll()
                    textFieldCoach.text?.removeAll()
                    textFieldCountPeople.text?.removeAll()
                    AlertAddData()
                case "Fitness":
                    let trainingData = data.child("Fitness")
                    trainingData.childByAutoId().setValue([
                        "couch": textCoach as Any,
                        "time": textTime as Any,
                        "countPeople": textFieldCountPeopleInt,
                        "users": []
                    ])
                    textFieldDirection.text?.removeAll()
                    textFieldTime.text?.removeAll()
                    textFieldCoach.text?.removeAll()
                    textFieldCountPeople.text?.removeAll()
                    AlertAddData()
                case "Airostretching":
                    let trainingData = data.child("Airostretching")
                    trainingData.childByAutoId().setValue([
                        "couch": textCoach as Any,
                        "time": textTime as Any,
                        "countPeople": textFieldCountPeopleInt,
                        "users": []
                    ])
                    textFieldDirection.text?.removeAll()
                    textFieldTime.text?.removeAll()
                    textFieldCoach.text?.removeAll()
                    textFieldCountPeople.text?.removeAll()
                    AlertAddData()
                default:
                    let alert = UIAlertController(title: "Ошибка", message: "Направление отсутсвует", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }

    }
 
    func AlertAddData() {
        let alert = UIAlertController(title: "Готово", message: "Расписание добавлено", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func textField() {
        textFieldTime.delegate = self
        textFieldDirection.delegate = self
        textFieldCoach.delegate = self
        textfield(textFieldDirection)
        textfield(textFieldCoach)
    }
    
    @IBAction func showAlert(_ sender: UITextField) {
        let alert = UIAlertController(title: "Выбор тренировки", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Stretching", style: .default, handler: { textFieldDirection in
            self.textFieldDirection.text = "Stretching"

        }))
        alert.addAction(UIAlertAction(title: "Airostretching", style: .default, handler: { textFieldDirection in
            self.textFieldDirection.text = "Airostretching"

        }))
        alert.addAction(UIAlertAction(title: "Fitness", style: .default, handler: { textFieldDirection in
            self.textFieldDirection.text = "Fitness"

        }))
        alert.addAction(UIAlertAction(title: "Выход", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
   
    @IBAction func showAlertCouch(_ sender: Any) {
        let alert = UIAlertController(title: "Выбор тренера", message: nil, preferredStyle: .actionSheet)
            switch textFieldDirection.text {
            case "Airostretching":
                alert.addAction(UIAlertAction(title: "Костя", style: .default, handler: { textFieldCoach in
                    self.textFieldCoach.text = "Костя"
                    
                }))
                alert.addAction(UIAlertAction(title: "Петя", style: .default, handler: { textFieldCoach in
                    self.textFieldCoach.text = "Петя"
                    
                }))
                alert.addAction(UIAlertAction(title: "Анна", style: .default, handler: { textFieldCoach in
                    self.textFieldCoach.text = "Анна"
                    
                }))
                alert.addAction(UIAlertAction(title: "Выход", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            case "Stretching":
                alert.addAction(UIAlertAction(title: "Маша", style: .default, handler: { textFieldCoach in
                    self.textFieldCoach.text = "Маша"
                    
                }))
                alert.addAction(UIAlertAction(title: "Ваня", style: .default, handler: { textFieldCoach in
                    self.textFieldCoach.text = "Ваня"
                    
                }))
                alert.addAction(UIAlertAction(title: "Саша", style: .default, handler: { textFieldCoach in
                    self.textFieldCoach.text = "Саша"
                    
                }))
                alert.addAction(UIAlertAction(title: "Выход", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            case "Fitness":
                alert.addAction(UIAlertAction(title: "Вера", style: .default, handler: { textFieldCoach in
                    self.textFieldCoach.text = "Вера"
                    
                }))
                alert.addAction(UIAlertAction(title: "Дима", style: .default, handler: { textFieldCoach in
                    self.textFieldCoach.text = "Дима"
                    
                }))
                alert.addAction(UIAlertAction(title: "Женя", style: .default, handler: { textFieldCoach in
                    self.textFieldCoach.text = "Женя"
                    
                }))
                alert.addAction(UIAlertAction(title: "Выход", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            
            default:
                let alert = UIAlertController(title: "Ошибка", message: "Выберите занятие", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
    }
    }
}

extension AdminMenuVC: UITextFieldDelegate {
    func textfield(_ textField: UITextField){
        textField.autocapitalizationType = .words
        textField.autocorrectionType = .yes
        textField.returnKeyType = .done
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
