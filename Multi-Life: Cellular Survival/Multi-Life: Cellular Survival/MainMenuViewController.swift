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
        println("Authenticating local user...");
        let localPlayer = GKLocalPlayer.localPlayer();
        localPlayer.authenticateHandler = { (view, error) -> Void in
            if (view != nil) {
                self.presentViewController(view, animated: true, completion: nil);
            }
            else if (localPlayer.authenticated) {
                println("Local player has been authenticated.");
            }
            else {
                println("Local player couldn't be auhenticated. Printing error...");
                println(error);
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.authenticateLocalUser();
    }
}
