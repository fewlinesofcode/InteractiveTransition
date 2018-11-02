//
//  CardDismissingAnimator.swift
//  InteractiveTransitions
//
//  Created by Oleksandr Glagoliev on 01/11/2018.
//  Copyright © 2018 Oleksandr Glagoliev. All rights reserved.
//

import UIKit

class CardDismissingAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    let duration: TimeInterval
    let finalFrame: CGRect
    let cornerRadius: CGFloat
    
    init(duration: TimeInterval,
         finalFrame: CGRect,
         cornerRadius: CGFloat = 0) {
        
        self.duration = duration
        self.finalFrame = finalFrame
        self.cornerRadius = cornerRadius
        
        super.init()
    }
    
    override init() {
        fatalError("Use `init(duration:, initialFrame:, finalFrame: , cornerRadius:)` instead")
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) else { return }
        guard let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) else { return }
        
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext),
                       animations: {
                        toVC.view.transform = CGAffineTransform(scaleX: 1, y: 1).translatedBy(x: 0, y: 0)
                        toVC.view.layer.cornerRadius = self.cornerRadius
                        toVC.view.layer.masksToBounds = true
                        toVC.view.alpha = 1
                        
                        fromVC.view.frame = self.finalFrame
                        fromVC.view.layer.cornerRadius = self.cornerRadius
                        
        }, completion: { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}


