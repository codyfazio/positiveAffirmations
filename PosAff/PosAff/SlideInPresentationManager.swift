//
//  SlideInPresentationManager.swift
//  TrafficWatch
//
//  Created by Cody Fazio on 2/4/17.
//  Copyright © 2017 OllieTech. All rights reserved.
//

import UIKit

enum PresentationDirection {
    case left, top, right, bottom, bottomFull
}

class SlideInPresentationManager: NSObject {
    
    //MARK: Properties
    var direction : PresentationDirection = .bottom
    var disableCompactHeight = false
}

//MARK: Transitioning Delegate
extension SlideInPresentationManager: UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
        let presentationController = SlideInPresentationController(presentedViewController: presented, presenting: presenting, direction: direction)
        presentationController.delegate = self
        return presentationController
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SlideInPresentationAnimator(direction: direction, isPresentation: true)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SlideInPresentationAnimator(direction: direction, isPresentation: false)
    }
}

//MARK: Adaptive Presentation Delegate
extension SlideInPresentationManager: UIAdaptivePresentationControllerDelegate  {
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        
        if traitCollection.verticalSizeClass == .compact && disableCompactHeight {
            return .overFullScreen
        } else {
            return .none
        }
    }
}
