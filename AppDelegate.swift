//
//  AppDelegate.swift
//  KioskProjB
//
//  Created by Keenan Grant on 6/22/17.
//  Copyright © 2017 Keenan Grant. All rights reserved.
//
import Google
import GoogleSignIn
import Firebase
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {

    var window: UIWindow?
    var vc = GoogleSignInViewController()
    
    //IMPORTANT
    override init() {
        super.init()
        FIRApp.configure()
        GIDSignIn.sharedInstance().clientID = FIRApp.defaultApp()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
    }

    private func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
//        // Initialize sign-in
//        var configureError: NSError?
//        GGLContext.sharedInstance().configureWithError(&configureError)
//        assert(configureError == nil, "Error configuring Google services: \(configureError)")
//        
//        GIDSignIn.sharedInstance().delegate = self
//        
//        return true
//        // Initialize sign-in
        var configureError: NSError?
        GGLContext.sharedInstance().configureWithError(&configureError)
        assert(configureError == nil, "Error configuring Google services: \(String(describing: configureError))")
        
        GIDSignIn.sharedInstance().delegate = self
        
        //Check if user is correctly signed in
        if GIDSignIn.sharedInstance().hasAuthInKeychain() {
            
        }
        else {
            
        }
        return true
    }

//IMPORTANT
    @available(iOS 9.0, *)
    func application(_ application: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        //return GIDSignIn.sharedInstance().handle(url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String, annotation: [:])
        return GIDSignIn.sharedInstance().handle(url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String, annotation: options[UIApplicationOpenURLOptionsKey.annotation])
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        if (error == nil) {
            // Perform any operations on signed in user here.
            // ...
        } else {
            print("\(String(describing: error?.localizedDescription))")
        }
//        if error != nil {
//            return
//        }
//        guard let authentication = user.authentication else {return}
//        let credential = FIRGoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
//        
//        FIRAuth.auth()?.signIn(with: credential) { (user, error) in
//
//            if error != nil {
//                return
//            }
//        }
//IMPORTANT
        if (error == nil) {
            // Perform any operations on signed in user here.
            _ = user.userID                  // For client-side use only!
            _ = user.authentication.idToken // Safe to send to the server
            _ = user.profile.name
            _ = user.profile.givenName
            _ = user.profile.familyName
            _ = user.profile.email
            print("signed in")
    
        } else {
            print("\(String(describing: error?.localizedDescription))")
        }
    }

    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
//         Perform any operations when the user disconnects from app here.
//         ...
//        GIDSignIn.sharedInstance().signInSilently()
//        GIDSignIn.sharedInstance().scopes.append("openid")
//        GIDSignIn.sharedInstance().scopes.append("https://www.googleapis.com/auth/drive")
//        if GIDSignIn.sharedInstance().hasAuthInKeychain() {
//            print("OH PLEASE DEAR GOD WORK")
//            vc.performSegue(withIdentifier: "PleaseMove", sender: self)
//            let viewController = vc.storyboard?.instantiateInitialViewController() //as? UIViewController
//            viewController?.present(viewController!, animated: true, completion: nil)
//        }
//        else {
//            
//        }
//
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}
