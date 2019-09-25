//
//  SlideInTransition.swift
//  SpendWiseApp
//
//  Created by Jason Mach on 9/18/19.
//  Copyright © 2019 Quan Tran. All rights reserved.
//

import UIKit

class SlideInTransition: NSObject,UIViewControllerAnimatedTransitioning {
    var isPresenting = false
    let dimmingView = UIView()
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toViewController = transitionContext.viewController(forKey: .to),
            let fromViewController = transitionContext.viewController(forKey: .from) else {return}
        let containerView = transitionContext.containerView
        let finalWidth = toViewController.view.bounds.width * 0.8
        let finalHeight = toViewController.view.bounds.height
        if isPresenting {
            
            // Add diming view
            dimmingView.backgroundColor = .black
            dimmingView.alpha = 0.0
            containerView.addSubview(dimmingView)
            dimmingView.frame = containerView.bounds
            // add menu view controller to container view
            containerView.addSubview(toViewController.view)
            
            toViewController.view.frame = CGRect(x: -finalWidth, y: 0, width: finalWidth, height: finalHeight)
        }
        //animate onto screen
        let transform = {
            toViewController.view.transform = CGAffineTransform(translationX: finalWidth, y: 0)
            self.dimmingView.alpha = 0.5// fade in(from summary to menu)
            
        }
        let identity = {
            fromViewController.view.transform = .identity
            self.dimmingView.alpha = 0.0// fade out(from menu to summary)

        }
        
        let duration = transitionDuration(using: transitionContext)
        let isCancelled = transitionContext.transitionWasCancelled
        UIView.animate(withDuration: duration, animations: {
            self.isPresenting ? transform(): identity()
        }) {(_) in
            transitionContext.completeTransition(!isCancelled)
        }
        
    }
    
}
