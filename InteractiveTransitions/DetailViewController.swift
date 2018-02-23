//
//  DetailViewController.swift
//  InteractiveTransitions
//
//  Created by Oleksandr Glagoliev on 10/29/17.
//  Copyright © 2017 Oleksandr Glagoliev. All rights reserved.
//

import UIKit

class DetailViewController: ContainerViewController {
        
    
    var interactor: Interactor? = nil
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.shared.statusBarStyle = .`default`
    }
    
    override func show(viewController: UIViewController) {
        super.show(viewController: viewController)
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(panGesture(_:)))
        viewController.view.addGestureRecognizer(pan)
    }
    
    @objc
    func panGesture(_ sender: UIPanGestureRecognizer) {
        let percentThreshold:CGFloat = 0.1
        
        // convert y-position to downward pull progress (percentage)
        let translation = sender.translation(in: view)
        let verticalMovement = translation.y / view.bounds.height
        let downwardMovement = fmaxf(Float(verticalMovement), 0.0)
        let downwardMovementPercent = fminf(downwardMovement, 1.0)
        let progress = CGFloat(downwardMovementPercent)
        
        guard let interactor = interactor else { return }
        
        switch sender.state {
        case .began:
            interactor.hasStarted = true
            dismiss(animated: true, completion: nil)
        case .changed:
            interactor.shouldFinish = progress > percentThreshold
            interactor.update(progress)
        case .cancelled:
            interactor.hasStarted = false
            interactor.cancel()
        case .ended:
            interactor.hasStarted = false
            interactor.shouldFinish
                ? interactor.finish()
                : interactor.cancel()
        default:
            break
        }
    }
}
