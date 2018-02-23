//
//  ViewController.swift
//  InteractiveTransitions
//
//  Created by Oleksandr Glagoliev on 10/29/17.
//  Copyright © 2017 Oleksandr Glagoliev. All rights reserved.
//

import UIKit

class MasterViewController: ContainerViewController {
    
    private let interactor = Interactor()
    private let detailViewController = DetailViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem?.target = self
        navigationItem.rightBarButtonItem?.action = #selector(showDetail)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let blue = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "blue")
        let yellow = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "yellow")
        
        show(viewController: blue)
        detailViewController.show(viewController: yellow)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    @objc
    func showDetail() {
        detailViewController.transitioningDelegate = self
        detailViewController.interactor = interactor
        detailViewController.modalPresentationStyle = .overCurrentContext
        present(detailViewController, animated: true, completion: nil)
    }
}

extension MasterViewController: UIViewControllerTransitioningDelegate {
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissAnimator()
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let presentAnimator = PresentAnimator()
        presentAnimator.originFrame = CGRect.zero
        return presentAnimator
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactor.hasStarted ? interactor : nil
    }
    
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactor.hasStarted ? interactor : nil
    }
    
}
