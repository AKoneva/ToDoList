//
//  TableViewController.swift
//  tableViewController
//
//  Created by Macbook Pro on 06.08.2020.
//  Copyright © 2020 Macbook Pro. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    @IBAction func pushEditAction(_ sender: Any) {
        tableView.setEditing(!tableView.isEditing, animated: true)
    }
    
    @IBAction func pushAdd(_ sender: Any) {
        let alertController = UIAlertController(title: "Create Item", message: "", preferredStyle: .alert)
        
        alertController.addTextField { (textField) in
            textField.placeholder = "New Item Name"
        }
        
        let alertAction1 = UIAlertAction(title: "Cancel", style: .default) { _ in }
        let alertAction2 = UIAlertAction(title: "Create", style: .default) { _ in
            let nameOfNewItem =  alertController.textFields![0].text
            if nameOfNewItem != "" {
                addItem(nameItem: nameOfNewItem!)
            }
            
            self.tableView.reloadData()
        }
        
        alertController.addAction(alertAction1)
        alertController.addAction(alertAction2)
        
        present(alertController, animated: true , completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        toDoList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let currentItem = toDoList[indexPath.row]
        cell.textLabel?.text = currentItem["name"] as? String
        if (currentItem["isCompleted"]  as? Bool) == true{
            cell.imageView?.image = UIImage(named: "check.png")
        } else {
            cell.imageView?.image = UIImage(named: "uncheck.png")
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            RemoveItem(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if  changeState(at: indexPath.row) {
            tableView.cellForRow(at: indexPath)?.imageView?.image = UIImage(named: "check.png")
        } else{
            tableView.cellForRow(at: indexPath)?.imageView?.image = UIImage(named: "uncheck.png")
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        moveItemFromTo(fromIndex: fromIndexPath.row , toIndex: to.row)
        tableView.reloadData()
    }
}
