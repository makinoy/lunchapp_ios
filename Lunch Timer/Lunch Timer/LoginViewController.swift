//
//  LoginViewController.swift
//  Lunch Timer
//
//  Created by makinoy on 10/18/14.
//  Copyright (c) 2014 makinoy. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, FBLoginViewDelegate {

    @IBOutlet var fbLoginView : FBLoginView!
    var fbUser: FBGraphUser!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

//        let fbLoginView = FBLoginView()

        fbLoginView.delegate = self
        fbLoginView.readPermissions = ["public_profile", "email", "user_friends"]

//        fbLoginView.center = self.view.center
//        self.view.addSubview(fbLoginView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func loginViewShowingLoggedInUser(loginView : FBLoginView!) {
        println("User Logged In")
    }

    func loginViewFetchedUserInfo(loginView : FBLoginView!, user: FBGraphUser) {
        println("User: \(user)")
        println("User ID: \(user.objectID)")
        println("User Name: \(user.name)")
        var userEmail = user.objectForKey("email") as String
        println("User Email: \(userEmail)")
        self.fbUser = user
        performSegueWithIdentifier("Next", sender: self)
    }

    func loginViewShowingLoggedOutUser(loginView : FBLoginView!) {
        println("User Logged Out")
    }

    func loginView(loginView : FBLoginView!, handleError:NSError) {
        println("Error: \(handleError.localizedDescription)")
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Next" {
            let navigationController = segue.destinationViewController as UINavigationController
            var viewController:TableViewController = navigationController.childViewControllers[0] as TableViewController
            viewController.user = self.fbUser
        }
    }
    
}

