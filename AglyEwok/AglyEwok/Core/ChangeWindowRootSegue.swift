//
//  AuthorizedSegue.swift
//  ukmdm
//
//  Created by Yevhen Herasymenko on 12/9/17.
//  Copyright © 2017 UK MDM. All rights reserved.
//

import UIKit

extension UIWindow {
    
    func set(rootViewController newRootViewController: UIViewController,
             withTransition transition: CATransition? = nil) {
        let previousViewController = rootViewController
        if let transition = transition {
            layer.add(transition, forKey: kCATransition)
        }
        
        rootViewController = newRootViewController
        if UIView.areAnimationsEnabled {
            UIView.animate(withDuration: CATransaction.animationDuration()) {
                newRootViewController.setNeedsStatusBarAppearanceUpdate()
            }
        } else {
            newRootViewController.setNeedsStatusBarAppearanceUpdate()
        }
        
        if let transitionViewClass = NSClassFromString("UITransitionView") {
            for subview in subviews where subview.isKind(of: transitionViewClass) {
                subview.removeFromSuperview()
            }
        }
        if let previousViewController = previousViewController {
            previousViewController.dismiss(animated: false) {
                previousViewController.view.removeFromSuperview()
            }
        }
    }
}

final class ChangeWindowRootSegue: UIStoryboardSegue {

    override func perform() {
        guard let window = source.view.window else { return }
        let transition = CATransition()
        transition.type = kCATransitionFade
        window.set(rootViewController: destination, withTransition: transition)
    }
    
}
