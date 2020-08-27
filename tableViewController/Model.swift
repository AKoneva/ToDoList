//
//  Model.swift
//  tableViewController
//
//  Created by Macbook Pro on 06.08.2020.
//  Copyright © 2020 Macbook Pro. All rights reserved.
//

import Foundation
import UserNotifications
import UIKit
var toDoList: [[String: Any]] {
    set{
        let defaults = UserDefaults.standard
           defaults.set(newValue, forKey: "ToDoDataKey")
           defaults.synchronize()
    }
    get{
        let defaults = UserDefaults.standard
        if let array = defaults.array(forKey:"ToDoDataKey") as? [[String: Any]]{
            return array
        }
        else{
            return []
        }
    }
}
//[["name":"Item1","isCompleted": true],["name":"Item2","isCompleted": false],["name":"Item3","isCompleted": false],["name":"Item4","isCompleted": false],["name":"Item5","isCompleted": false],["name":"Item6","isCompleted": false]]

func addItem(nameItem: String, isCompleted: Bool = false)  {
    toDoList.append(["name": nameItem, "isCompleted": isCompleted])
    setBadge()
}
func RemoveItem(index: Int){
    toDoList.remove(at: index)
    setBadge()
}
func changeState(at Item: Int) -> Bool{
    toDoList[Item]["isCompleted"] = !(toDoList[Item]["isCompleted"] as! Bool)
    setBadge()
    return toDoList[Item]["isCompleted"] as! Bool
}

func moveItemFromTo(fromIndex: Int, toIndex:Int){
    let Item = toDoList[fromIndex]
           toDoList.remove(at: fromIndex)
           toDoList.insert(Item, at: toIndex)
          
}

func requestForNotify(){
    UNUserNotificationCenter.current().requestAuthorization(options: [.badge]) { (isEnable, error) in
        
    }
}

func setBadge(){
    var totalBadgeNumber = 0
    for item in toDoList{
        if (item["isCompleted"] as? Bool) == false{
            totalBadgeNumber += 1
        }
    }
    UIApplication.shared.applicationIconBadgeNumber = totalBadgeNumber
}
