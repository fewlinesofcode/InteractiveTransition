//
//  ContainerViewController.swift
//  InteractiveTransitions
//
//  Created by Oleksandr Glagoliev on 11/24/17.
//  Copyright © 2017 Oleksandr Glagoliev. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {
    private var current: UIViewController?
    
    func show(viewController: UIViewController) {
        if current != nil {
            current?.view.removeFromSuperview()
            current?.removeFromParentViewController()
        }
        current = viewController
        view.addSubview(viewController.view)
        addChildViewController(viewController)
        viewController.view.frame = view.bounds
        viewController.didMove(toParentViewController: self)
    }
}

