//
//  ViewController.swift
//  KioskProjB
//
//  Created by Keenan Grant on 6/22/17.
//  Copyright © 2017 Keenan Grant. All rights reserved.
//

import UIKit
import os.log

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nameInput: UITextField!
    @IBOutlet weak var badgeInput: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var dateLabel: UILabel!
    
    var passName: Name?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        badgeInput.delegate = self
        nameInput.delegate = self

        //Temporary Date placeholder
        let currentDate = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let dateString = formatter.string(from: currentDate)
        self.dateLabel.text = dateString
        
        
        if let passName = passName {
            navigationItem.title = passName.namer
            nameInput.text = passName.namer
            badgeInput.text = passName.badge
        }
        //Only if text has valid name and badge
        holdSaveButtonState()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //Hides the keyboard!
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        holdSaveButtonState()
        navigationItem.title = textField.text
    }
    
    
    //Navigation
    
    //Dismisses current scene, returns to previous without saving information
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        //Two different ways of using cancel
        let isPushingAddCell = presentingViewController is UINavigationController
        if isPushingAddCell {
            //Only works when adding a new cell
            dismiss(animated: true, completion: nil)
        }
        else if let myNavigationController = navigationController {
            myNavigationController.popViewController(animated: true)
        }
        else {
            fatalError("The viewController is not inside the navigation controller")
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        // Allow change in destination only if save button is pressed
        guard let button = sender as? UIBarButtonItem, button === saveButton
            else {
                os_log("CANCEL, save button not pressed", log: OSLog.default, type: .debug)
                return
        }
        
        let name = nameInput.text ?? ""
        let badge = badgeInput.text ?? ""
        
        //Pass to NameTableViewController after the segue
        passName = Name(namer: name, badge: badge)
    }

    //Save button will not work if either badge or name field is empty
    private func holdSaveButtonState() {
        let nameText = nameInput.text ?? ""
        let badgeText = badgeInput.text ?? ""
        saveButton.isEnabled = !nameText.isEmpty && !badgeText.isEmpty
    }
    
}

