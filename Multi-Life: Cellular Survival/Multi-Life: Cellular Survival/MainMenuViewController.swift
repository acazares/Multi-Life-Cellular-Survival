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
    
    override func viewDidLoad() {
        super.viewDidLoad();
        GCHelper.sharedInstance.authenticateLocalPlayer(self);
    }
}
