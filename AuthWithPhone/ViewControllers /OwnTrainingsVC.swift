//
//  OwnTraining.swift
//  AuthWithPhone
//
//  Created by Евгений Григоренко on 19.04.22.
//  Copyright © 2022 Admin. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth


class OwnTraining: UITableViewController {
    let data = Database.database().reference()
    var firebaseDataS = [Direction]()
    var firebaseDataA = [Direction]()
    var firebaseDataF = [Direction]()
    
    let uid = Auth.auth().currentUser?.uid
    let sectionNames = ["Aerostretching", "Stretching", "Fitness"]
    var arrayData = [[Direction]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Личные занятия"
        self.kindTrainings()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    // MARK: - Read data in Firebase
    
    func kindTrainings() {
        readDirection(training: "Airostretching")
        readDirection(training: "Stretching")
        readDirection(training: "Fitness")
    }
    

    
    func readDirection(training: String){
            data.child(training).observeSingleEvent(of: .value) { snapshot  in
            switch training {
            case "Airostretching":
                for snap in snapshot.children.allObjects as! [DataSnapshot] {
                    if let dataValue = self.dataSnapshot(snap, snapshot: snapshot) {
                        
                        self.firebaseDataA.append(dataValue)
                    }
                }
            case "Stretching":
                for snap in snapshot.children.allObjects as! [DataSnapshot] {
                    if let dataValue = self.dataSnapshot(snap, snapshot: snapshot) {
                        self.firebaseDataS.append(dataValue)
                    }
                }
            case "Fitness":
                for snap in snapshot.children.allObjects as! [DataSnapshot] {
                    if let dataValue = self.dataSnapshot(snap, snapshot: snapshot) {
                        self.firebaseDataF.append(dataValue)
                    }
                }
            default:
                break
            }
            self.tableView.reloadData()
        }
    }
    
    func dataSnapshot(_ snap: DataSnapshot, snapshot: DataSnapshot) -> Direction? {
        let id = snap.key
        let trainingType = snapshot.key
        let data = snap.value  as? [String:AnyObject]
        let users = data?["users"] as? [String:String]
        if let dataUsers = users {
            for (_, value) in dataUsers {
                if value == uid! {
                    let couch = data?["couch"]
                    let time = data?["time"]
                    let count = data?["countPeople"]
                    let direction = Direction(trainingType: trainingType,couch: couch as? String,
                                              time: time as? String,
                                              countPeople: count as? Int,
                                              id: id, user: User(userId: users))
                    return direction
                }
            }
        }
        return nil

    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionNames.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        self.arrayData = [self.firebaseDataA, self.firebaseDataS, self.firebaseDataF]
        return  arrayData[section].count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sectionNames[section]
    } 
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.textLabel?.text = "Тренер: " + arrayData[indexPath.section][indexPath.row].couch!
            cell.detailTextLabel?.text = arrayData[indexPath.section][indexPath.row].time
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            switch arrayData[indexPath.section][indexPath.row].trainingType {
            case "Airostretching":
                for (key, data) in arrayData[indexPath.section][indexPath.row].user!.userId! {
                    if data == uid {
                        let userOrderTrening = arrayData[indexPath.section][indexPath.row].countPeople! + 1
                        self.data.child("Airostretching").child(arrayData[indexPath.section][indexPath.row].id!).child("countPeople").setValue(userOrderTrening)
                        self.data.child("Airostretching").child(arrayData[indexPath.section][indexPath.row].id!).child("users").child(key).setValue(nil)
                        firebaseDataA.remove(at: indexPath.row)
                    }
                }
            case "Stretching":
                for (key, data) in arrayData[indexPath.section][indexPath.row].user!.userId! {
                    if data == uid {
                        let userOrderTrening = arrayData[indexPath.section][indexPath.row].countPeople! + 1
                        self.data.child("Stretching").child(arrayData[indexPath.section][indexPath.row].id!).child("countPeople").setValue(userOrderTrening)
                        self.data.child("Stretching").child(arrayData[indexPath.section][indexPath.row].id!).child("users").child(key).setValue(nil)
                        firebaseDataS.remove(at: indexPath.row)

                    }
                }
            case "Fitness":
                for (key, data) in arrayData[indexPath.section][indexPath.row].user!.userId! {
                    if data == uid {
                        let userOrderTrening = arrayData[indexPath.section][indexPath.row].countPeople! + 1
                        self.data.child("Fitness").child(arrayData[indexPath.section][indexPath.row].id!).child("countPeople").setValue(userOrderTrening)
                        self.data.child("Fitness").child(arrayData[indexPath.section][indexPath.row].id!).child("users").child(key).setValue(nil)
                        firebaseDataF.remove(at: indexPath.row)
                    }
                }
            default:
                break
            }
            self.tableView.reloadData()
        
        }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

