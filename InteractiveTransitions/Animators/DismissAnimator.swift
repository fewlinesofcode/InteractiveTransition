//
//  DismissAnimator.swift
//  InteractiveTransitions
//
//  Created by Oleksandr Glagoliev on 10/29/17.
//  Copyright © 2017 Oleksandr Glagoliev. All rights reserved.
//

import UIKit

class DismissAnimator: NSObject {
    var transitionDuration = TimeInterval(0.3)
}

extension DismissAnimator : UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return transitionDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
            let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
            else {
                return
        }
        let screenBounds = UIScreen.main.bounds
        let bottomLeftCorner = CGPoint(x: 0, y: screenBounds.height)
        let finalFrame = CGRect(origin: bottomLeftCorner, size: screenBounds.size)
        
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext),
            animations: {
                fromVC.view.frame = finalFrame
                toVC.view.frame = transitionContext.finalFrame(for: toVC)
                toVC.view.layer.cornerRadius = 0
                toVC.view.alpha = 1
                toVC.view.layoutIfNeeded()
        }, completion: { _ in
            toVC.view.layoutIfNeeded()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            
        })
    }
}
