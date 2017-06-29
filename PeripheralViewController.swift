//
//  PeripheralViewController.swift
//  KioskProjB
//
//  Created by Keenan Grant on 6/29/17.
//  Copyright © 2017 Keenan Grant. All rights reserved.
//

import UIKit

class PeripheralViewController: UIViewController {
    
    @IBOutlet weak var peripheralName: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

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
    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
