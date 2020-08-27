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
       //create Alert
        let alertController = UIAlertController(title: "Create Item", message: "", preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "New Item Name"
        }
        //buttons
        let alertAction1 = UIAlertAction(title: "Cancel", style: .default){
            (alert) in   }
        let alertAction2 = UIAlertAction(title: "Create", style: .default){
                   (alert) in
            //Add new Item
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

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return toDoList.count
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let currentItem = toDoList[indexPath.row]
        cell.textLabel?.text = currentItem["name"] as? String
        if (currentItem["isCompleted"]  as? Bool) == true{
           
            cell.imageView?.image = UIImage(named: "check.png")
        }else{
            cell.imageView?.image = UIImage(named: "uncheck.png")
            
        }
        
        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            RemoveItem(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
   
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if  changeState(at: indexPath.row){
     
            tableView.cellForRow(at: indexPath)?.imageView?.image = UIImage(named: "check.png")

        }else{
            tableView.cellForRow(at: indexPath)?.imageView?.image = UIImage(named: "uncheck.png")


        }
    }

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        moveItemFromTo(fromIndex: fromIndexPath.row , toIndex: to.row)
         tableView.reloadData()
    }
   

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
