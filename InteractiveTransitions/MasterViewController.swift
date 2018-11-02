//
//  ViewController.swift
//  InteractiveTransitions
//
//  Created by Oleksandr Glagoliev on 10/29/17.
//  Copyright © 2017 Oleksandr Glagoliev. All rights reserved.
//

import UIKit



class AnotherViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Another"
    }
}

class MasterViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem?.target = self
        navigationItem.rightBarButtonItem?.action = #selector(showDetail)
    }
    
    @objc
    func showDetail() {
        let detailViewController = CardNavigationController(rootViewController: AnotherViewController())
        detailViewController.modalPresentationStyle = .overCurrentContext // Important!
        present(detailViewController, animated: true, completion: nil)
    }
}
