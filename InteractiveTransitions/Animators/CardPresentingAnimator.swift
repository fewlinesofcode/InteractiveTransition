//
//  CardPresentingAnimator.swift
//  InteractiveTransitions
//
//  Created by Oleksandr Glagoliev on 01/11/2018.
//  Copyright © 2018 Oleksandr Glagoliev. All rights reserved.
//

import UIKit

class CardPresentingAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    let duration: TimeInterval
    let initialFrame: CGRect
    let finalFrame: CGRect
    let cornerRadius: CGFloat
    
    init(duration: TimeInterval,
         initialFrame: CGRect,
         finalFrame: CGRect,
         cornerRadius: CGFloat = 0) {
        
        self.duration = duration
        self.initialFrame = initialFrame
        self.finalFrame = finalFrame
        self.cornerRadius = cornerRadius
        
        super.init()
    }
    
    override init() {
        fatalError("Use `init(duration: , initialFrame:, finalFrame: , cornerRadius:)` instead")
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) else { return }
        guard let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) else { return }
        
        toVC.view.frame = initialFrame
        
        let wdiff: CGFloat = 20
        let scale = (fromVC.view.bounds.width - wdiff) / fromVC.view.bounds.width
        
        transitionContext.containerView.addSubview(toVC.view)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            toVC.view.transform = CGAffineTransform(translationX: 0, y: self.finalFrame.minY)
            toVC.view.frame = self.finalFrame
            toVC.view.layer.cornerRadius = self.cornerRadius
            toVC.view.layer.masksToBounds = true
            
            fromVC.view.transform = CGAffineTransform(scaleX: scale, y: scale).translatedBy(x: 0, y: wdiff + 40)
            fromVC.view.alpha = 0.6
            fromVC.view.layer.cornerRadius = self.cornerRadius
            fromVC.view.layer.masksToBounds = true
        }, completion: { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}
