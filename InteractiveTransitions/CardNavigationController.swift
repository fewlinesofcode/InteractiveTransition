//
//  CardViewController.swift
//  InteractiveTransitions
//
//  Created by Oleksandr Glagoliev on 10/29/17.
//  Copyright © 2017 Oleksandr Glagoliev. All rights reserved.
//

import UIKit

class CardNavigationController: UINavigationController {
    private var interactor = UIPercentDrivenInteractiveTransition()
    
    fileprivate var hasStarted = false
    fileprivate var shouldFinish = false
    
    var cornerRadius: CGFloat = 10
    
    var initialFrameForAppearingViewController = CGRect(x: 0, y: UIScreen.main.bounds.height - 44, width: UIScreen.main.bounds.width, height: 44)
    var finalFrameForDisappearingViewController = UIScreen.main.bounds.offsetBy(dx: 0, dy: UIScreen.main.bounds.height)
    var finalFrameForAppearingViewController = UIScreen.main.bounds.offsetBy(dx: 0, dy: 100)
    var animationDuration: TimeInterval = 0.3
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        transitioningDelegate = self
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        transitioningDelegate = self
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        transitioningDelegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(panGesture(_:)))
        view.addGestureRecognizer(pan)
        view.backgroundColor = .yellow
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
        
        switch sender.state {
        case .began:
            hasStarted = true
            dismiss(animated: true, completion: nil)
        case .changed:
            shouldFinish = progress > percentThreshold
            interactor.update(progress)
        case .cancelled:
            hasStarted = false
            interactor.cancel()
        case .ended:
            hasStarted = false
            shouldFinish ? interactor.finish() : interactor.cancel()
        default:
            break
        }
    }
}

extension CardNavigationController: UIViewControllerTransitioningDelegate {
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CardDismissingAnimator(duration: animationDuration, finalFrame: finalFrameForDisappearingViewController, cornerRadius: cornerRadius)
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CardPresentingAnimator(duration: animationDuration, initialFrame: initialFrameForAppearingViewController, finalFrame: finalFrameForAppearingViewController, cornerRadius: cornerRadius)
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return hasStarted ? interactor : nil
    }
    
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return hasStarted ? interactor : nil
    }
}
