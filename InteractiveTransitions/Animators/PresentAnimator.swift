//
//  PresentAnimator.swift
//  InteractiveTransitions
//
//  Created by Oleksandr Glagoliev on 10/30/17.
//  Copyright © 2017 Oleksandr Glagoliev. All rights reserved.
//

import UIKit

class PresentAnimator: NSObject {
    var transitionDuration = TimeInterval(0.3)
    var originFrame = CGRect.zero
    var cornerRadius = CGFloat(10)
}

extension PresentAnimator : UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return transitionDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
            let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
            else { return }
        
        let containerView = transitionContext.containerView
        containerView.addSubview(toVC.view)
        toVC.view.frame = originFrame
        let finalFrame = UIScreen.main.bounds.offsetBy(dx: 0, dy: 60)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext),
                       animations: {
                        toVC.view.frame = finalFrame
                        toVC.view.layer.cornerRadius = self.cornerRadius
                        toVC.view.layer.masksToBounds = true
                        toVC.view.layoutIfNeeded()
                        
                        fromVC.view.frame = transitionContext.initialFrame(for: fromVC).insetBy(dx: 20, dy: 20)
                        fromVC.view.layer.cornerRadius = self.cornerRadius
                        fromVC.view.layer.masksToBounds = true
                        fromVC.view.layoutIfNeeded()
                        fromVC.view.alpha = 0.6
        }, completion: { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}
