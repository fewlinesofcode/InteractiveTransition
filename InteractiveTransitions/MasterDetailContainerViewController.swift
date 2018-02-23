//
//  MasterDetailContainerViewController.swift
//  InteractiveTransitions
//
//  Created by Oleksandr Glagoliev on 11/29/17.
//  Copyright © 2017 Oleksandr Glagoliev. All rights reserved.
//

import UIKit

class MasterDetailContainerViewController: UIViewController {

    private var masterViewController: MasterViewController = MasterViewController()
    
    var initialFrameForDetailViewController: CGRect = CGRect.zero
    var finalFrameForDetailViewController: CGRect = CGRect.zero
    
    var initialFrameForMasterViewController: CGRect = CGRect.zero
    var finalFrameForMasterViewController: CGRect = CGRect.zero
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        view.addSubview(masterViewController.view)
        addChildViewController(masterViewController)
        masterViewController.view.frame = view.bounds
        masterViewController.didMove(toParentViewController: self)
    }
}
