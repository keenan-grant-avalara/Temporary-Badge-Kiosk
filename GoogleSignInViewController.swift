//
//  GoogleSignInViewController.swift
//  KioskProjB
//
//  Created by Keenan Grant on 7/7/17.
//  Copyright © 2017 Keenan Grant. All rights reserved.
//

import FirebaseCore
import GoogleSignIn
import UIKit
import Firebase
import Google

class GoogleSignInViewController: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate {
    
    @IBOutlet weak var signInButton: GIDSignInButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signIn()
        //GIDSignIn.sharedInstance().signInSilently()
        GIDSignIn.sharedInstance().clientID = FIRApp.defaultApp()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    //IMPORTANT
    public func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser, withError error: Error!) {
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().scopes.append("openid")
        GIDSignIn.sharedInstance().scopes.append("https://www.googleapis.com/auth/drive")
        //GIDSignIn.sharedInstance().signInSilently()
        //print("I AM HERE ", FIRAuth.auth()?.currentUser as Any)
        print("CURRENT USER ", GIDSignIn.sharedInstance().currentUser)
        print("I AM HERE ", GIDSignIn.sharedInstance().hasAuthInKeychain())
        print("FIRAUTH ", FIRAuth.auth()?.currentUser as Any)
        //if FIRAuth.auth()?.currentUser != nil {
        if GIDSignIn.sharedInstance().hasAuthInKeychain() {
            self.performSegue(withIdentifier: "PleaseMove", sender: self)
            let viewController = self.storyboard?.instantiateInitialViewController() //as? UIViewController
            self.present(viewController!, animated: true, completion: nil)
        }
        else {
                    
        }
//        for _ in 0...2 {
//        if GIDSignIn.sharedInstance().hasAuthInKeychain() {
//            self.performSegue(withIdentifier: "PleaseMove", sender: self)
//            let viewController = self.storyboard?.instantiateInitialViewController() //as? UIViewController
//            self.present(viewController!, animated: true, completion: nil)
        //}
        //}
        
        //if let authentication = user.authentication
        //if GIDSignIn.sharedInstance().hasAuthInKeychain() {
        
            
//            let credential = FIRGoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
//            
//            FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) -> Void in
//                if error != nil
//                {
//                    print("Problem at signing in with google with error : \(error)")
//                    
//                }
//                else if error == nil{
//                    print("user successfully signed in through GOOGLE! uid:\(FIRAuth.auth()!.currentUser!.uid)")
////                    self.performSegue(withIdentifier: "PleaseMove", sender: self)
////                    let viewController = self.storyboard?.instantiateInitialViewController() as? UIViewController
////                    self.present(viewController!, animated: true, completion: nil)
//                }
            //})
        
    }
    //IMPORTANT
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        
    }
    //IMPORTANT
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        GIDSignIn.sharedInstance().uiDelegate = self
//        GIDSignIn.sharedInstance().scopes.append("openid")
//        GIDSignIn.sharedInstance().scopes.append("https://www.googleapis.com/auth/drive")
//        GIDSignIn.sharedInstance().signInSilently()
//        //print("I AM HERE ", FIRAuth.auth()?.currentUser as Any)
//        print("CURRENT USER ", GIDSignIn.sharedInstance().currentUser)
//        print("I AM HERE ", GIDSignIn.sharedInstance().hasAuthInKeychain())
//        print("FIRAUTH ", FIRAuth.auth()?.currentUser)
//        //if FIRAuth.auth()?.currentUser != nil {
//        if GIDSignIn.sharedInstance().hasAuthInKeychain() {
//            self.performSegue(withIdentifier: "PleaseMove", sender: self)
//            let viewController = self.storyboard?.instantiateInitialViewController() //as? UIViewController
//            self.present(viewController!, animated: true, completion: nil)
//        }
//        else {
//            
//        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
