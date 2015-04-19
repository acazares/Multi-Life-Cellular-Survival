//
//  MainMenuViewController.swift
//  Multi-Life: Cellular Survival
//
//  Created by Alexander Cazares on 3/28/15.
//  Copyright (c) 2015 Alexander Cazares. All rights reserved.
//

import Foundation
import GameKit

class MainMenuViewController: UIViewController {
    
    func authenticateLocalUser() {
        println("Authenticating local player...");
        let localPlayer = GKLocalPlayer.localPlayer(); // The user on "this" device
        localPlayer.authenticateHandler = { (view, error) -> Void in // Authentication handler
            if (view != nil) { // The view can be displayed
                self.presentViewController(view, animated: true, completion: nil); // Present the authentication view
            }
            else if (localPlayer.authenticated) { // The user has already been authenticated
                println("Local player has been authenticated.");
                self.dismissViewControllerAnimated(true, completion: nil);
            }
            else { // An error occurred
                println("Local player couldn't be auhenticated. Printing error...");
                println(error); // Print error
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.authenticateLocalUser(); // Log in the user to GameCenter
    }
}
