//
//  TableViewController.swift
//  AuthWithPhone
//
//  Created by Admin on 14/12/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth


var buttonTag: Int?

class TableTypeTrainingsVC: UITableViewController {
    let data = Database.database().reference()
    var firebaseData = [Direction]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        DispatchQueue.main.async {
            self.titleNavigationBar()
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
        func upDateTraining(training: String) {
            let data = Database.database().reference()
            let dataDirection: Direction
            dataDirection = self.firebaseData[indexPath.row]
            guard let uid = Auth.auth().currentUser?.uid else { return }
            
            data.child(training).child(dataDirection.id!).child("users").observeSingleEvent(of: .value) { snapshot  in
                var array: [String] = []
                for snapshot in snapshot.children.allObjects as! [DataSnapshot] {
                    let value: String = snapshot.value as! String
                    array.append(value)
                }
                if dataDirection.countPeople! <= 0 {
                    self.alertCountPeople()
                } else if array.contains(uid) != true{
                    let userOrderTrening = dataDirection.countPeople! - 1
                    data.child(training).child(dataDirection.id!).child("countPeople").setValue(userOrderTrening)
                    data.child(training).child(dataDirection.id!).child("users").childByAutoId().setValue(uid)
                    self.alertSingUp()
                    
                } else {
                    self.alertYouSingUpYet()
                }
            }
        }
        switch buttonTag {
        case 1:
            upDateTraining(training: "Airostretching")
            self.tableView.reloadData()

        case 2:
            upDateTraining(training: "Stretching")
            self.tableView.reloadData()

        case 3:
            upDateTraining(training: "Fitness")
            self.tableView.reloadData()
        default: break
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.firebaseData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        let dataDirection: Direction
        dataDirection = self.firebaseData[indexPath.row]
        switch buttonTag {
        case 1:
            cell.textLabel?.text = "Тренер: " + dataDirection.couch!
            cell.detailTextLabel?.text = (dataDirection.time! + "; Количество мест: " + String(dataDirection.countPeople!))
        case 2:
            cell.textLabel?.text = "Тренер: " + dataDirection.couch!
            cell.detailTextLabel?.text = (dataDirection.time! + "; Количество мест: " + String(dataDirection.countPeople!))
        case 3:
            cell.textLabel?.text = "Тренер: " + dataDirection.couch!
            cell.detailTextLabel?.text = (dataDirection.time! + "; Количество мест: " + String(dataDirection.countPeople!))
        default: break
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        func delete(training: String) {
            let training = data.child(training)
            let dataDirection: Direction
            dataDirection = self.firebaseData[indexPath.row]
            guard let idObject = dataDirection.id else {return}
            training.child(idObject).setValue(nil)
            firebaseData.remove(at: indexPath.row)
            tableView.reloadData()
        }
        switch buttonTag {
        case 1:
            delete(training: "Airostretching")
        case 2:
            delete(training: "Stretching")
        case 3:
            delete(training: "Fitness")
        default: break
        }
    }
    
    func titleNavigationBar() {
        func readDirection(training: String){
            title = training
            data.child(training).observeSingleEvent(of: .value) { snapshot  in
                for snapshot in snapshot.children.allObjects as! [DataSnapshot] {
                    let id = snapshot.key
                    let data = snapshot.value  as? [String:AnyObject]
                    let couch = data?["couch"]
                    let time = data?["time"]
                    let count = data?["countPeople"]
                    let users = data?["users"]
                let direction = Direction(trainingType: "",couch: couch as? String,
                                          time: time as? String,
                                          countPeople: count as? Int,
                                          id: id, user: users as? User)
                    self.firebaseData.append(direction)
                    self.tableView.reloadData()
                }
            }
        }
        switch buttonTag {
        case 1:
            readDirection(training: "Airostretching")
        case 2:
            readDirection(training: "Stretching")
        case 3:
            readDirection(training: "Fitness")
        default: break
        }
    }
    
    func alertSingUp() {
        let alert = UIAlertController(title: "Запись", message: "Вы записались на занятие.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    func alertYouSingUpYet() {
        let alert = UIAlertController(title: "Запись", message: "Вы уже записаны на занятие.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    func alertCountPeople() {
        let alert = UIAlertController(title: "Запись", message: "Мест нет", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}



