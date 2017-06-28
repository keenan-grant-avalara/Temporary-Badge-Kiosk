//
//  NameTableViewController.swift
//  KioskProjB
//
//  Created by Keenan Grant on 6/22/17.
//  Copyright © 2017 Keenan Grant. All rights reserved.
//

import UIKit
import os.log


class NameTableViewController: UITableViewController {
    
    var names = [Name]()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
        if let storedNames = loadNames() {
            names += storedNames
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }


    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellCheck = "BadgeTableViewCell"
        
        // cast returned obect from TableViewCell to BadgeTableViewCell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellCheck, for: indexPath) as? BadgeTableViewCell
            else {
                fatalError("Major Fail, cell was not apart of BadgeTableViewCell")
        }
        // grabs name from array
        let name = names[indexPath.row]
        
        cell.nameCell.text = name.namer
        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            names.remove(at: indexPath.row)
            //Saves whenever an entry is deleted
            saveNames()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            case "AddItem":
            os_log("Adding new name", log: OSLog.default, type: .debug)
            
            case "BackToMain":
            os_log("Returning to main page", log: OSLog.default, type: .debug)
            
            case "ShowInfo":
            guard let nameViewController = segue.destination as? ViewController else {
                fatalError("Unexpected destination: \(String(describing: sender))")
            }
            
            guard let chosenBadgeCell = sender as? BadgeTableViewCell else {
                fatalError("Unexpected sender")
            }
            
            guard let indexPath = tableView.indexPath(for: chosenBadgeCell) else {
                fatalError("Chosen cell is not in table")
            }
            
            let chosenBadge = names[indexPath.row]
            nameViewController.passName = chosenBadge
            
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
            
        }
    }
    
    
    //Actions
    @IBAction func unwindNameToList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? ViewController, let passName = sourceViewController.passName {
            
            if let chosenIndexPath = tableView.indexPathForSelectedRow {
                //Update existing table cell
                names[chosenIndexPath.row] = passName
                tableView.reloadRows(at: [chosenIndexPath], with: .none)
            }
            else {
                //Add new cell
                let replacementIndexPath = IndexPath(row: names.count, section: 0)
                names.append(passName)
                tableView.insertRows(at: [replacementIndexPath], with: .automatic)
            }
            //Saves names array when one is added or one is updated
            saveNames()
            
        }
        
    }
    //Attempts to save names array
    private func saveNames() {
        let successfulSave = NSKeyedArchiver.archiveRootObject(names, toFile: Name.ArchiveURL.path)
        if successfulSave {
            os_log("Names saved", log: OSLog.default, type: .debug)
        }
        else {
            os_log("Names not saved", log: OSLog.default, type: .error)
        }
    }
    
    //Attempts to load saved names array
    private func loadNames() -> [Name]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Name.ArchiveURL.path) as? [Name]
    }
}
