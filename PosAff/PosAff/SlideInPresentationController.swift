//
//  SlideInPresentationController.swift
//  TrafficWatch
//
//  Created by Cody Fazio on 2/4/17.
//  Copyright © 2017 OllieTech. All rights reserved.
//

import UIKit

class SlideInPresentationController: UIPresentationController {
    
    //MARK: Properties
    fileprivate var dimmingView: UIView!
    private var direction: PresentationDirection
    
    override var frameOfPresentedViewInContainerView: CGRect {
        
        //Create a frame and size it
        var frame: CGRect = .zero
        frame.size = size(forChildContentContainer: presentedViewController, withParentContainerSize: containerView!.bounds.size)
        
        //For .right and .bottom, we shift the frame appropriately
        switch direction {
        case .right:
            frame.origin.x = containerView!.frame.width*(1.0/3.0)
        case .bottom:
            frame.origin.y = containerView!.frame.height*(1.0/3.0)
        case .bottomFull:
            frame.origin.y = containerView!.frame.height*(0.25/3.0)
        default:
            frame.origin = .zero
        }
        return frame
    }
    
    //MARK: Initialization
    init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?, direction: PresentationDirection) {
        self.direction = direction
        
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        
        setupDimmingView()
    }
    
    //MARK: Presentation Overrides
    override func presentationTransitionWillBegin() {
        
        //Insert dimmingView as subView
        containerView?.insertSubview(dimmingView, at: 0)
        
        //Set constraints for dimmingView
        NSLayoutConstraint.activate(
        NSLayoutConstraint.constraints(withVisualFormat: "V:|[dimmingView]|", options: [], metrics: nil, views: ["dimmingView": dimmingView]))
        NSLayoutConstraint.activate(
            NSLayoutConstraint.constraints(withVisualFormat: "H:|[dimmingView]|", options: [], metrics: nil, views: ["dimmingView": dimmingView]))
        
        //Use coordinator to animate dimming during transition
        guard let coordinator = presentedViewController.transitionCoordinator else {
            dimmingView.alpha = 1.0
            return
        }
        
        coordinator.animate(alongsideTransition:  {_ in
            self.dimmingView.alpha = 1.0
        })
    }
    
    override func dismissalTransitionWillBegin() {
        guard let coordinator = presentedViewController.transitionCoordinator else {
            dimmingView.alpha = 0.0
            return
        }
        
        coordinator.animate(alongsideTransition: {  _ in
                self.dimmingView.alpha = 0.0
        })
    }
    
    override func containerViewWillLayoutSubviews() {
        presentedView?.frame = frameOfPresentedViewInContainerView
    }
    
    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        switch direction {
        case .left, .right:
            return CGSize(width: parentSize.width*(2.0/3.0), height: parentSize.height)
        case .top, .bottom:
            return CGSize(width: parentSize.width, height: parentSize.height*(2.0/3.0))
        case .bottomFull:
            return CGSize(width: parentSize.width, height: parentSize.height*(2.75/3.0))
        }
    }
}

//MARK: Private Dimming
private extension SlideInPresentationController {
    func setupDimmingView() {
        dimmingView = UIView()
        dimmingView.translatesAutoresizingMaskIntoConstraints = false
        dimmingView.backgroundColor = UIColor(white: 0.0, alpha: 0.5)
        dimmingView.alpha = 0.0
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(recognizer:)))
        dimmingView.addGestureRecognizer(recognizer)
    }
    
    dynamic func handleTap(recognizer: UITapGestureRecognizer) {
        presentingViewController.dismiss(animated: true)
    }
}
