//**
/**
 FileName : ActivitySpinner
 Description : Custom class for the Activity Indicator
 Copyright : Copyright © 2019 Cognizant. All rights reserved.
 Created Date : 01/23/19
 =============================================================================
 */

import UIKit
import TinyConstraints

enum SpinnerLocation {
    case left
    case center
    case right
}

final class ActivitySpinner: NSObject {
    
    fileprivate static let sharedSpinner = ActivitySpinner()
    private let container = ContainerView()
    
    func show(in view: UIView? = nil, location: SpinnerLocation? = SpinnerLocation.center) {
        
        var aView: UIView
        
        if let view = view {
            aView = view
        } else {
            aView = UIApplication.shared.keyWindow!
        }
        
        if  !aView.subviews.contains(container) {
            aView.addSubview(container)
            container.frame.origin = CGPoint.zero
            container.frame.size = aView.frame.size
            container.autoresizingMask = [ .flexibleHeight, .flexibleWidth ]
            container.isHidden = true
            container.spinner.frame = container.frame
            container.location = location
        }
        
        self.showContent()
    }
    
    func hide() {
        container.hideFrameView()
    }
    
    func showContent() {
        container.showFrameView()
    }
}

final class ContainerView: UIView {
    
    let spinner: UIActivityIndicatorView
    var location: SpinnerLocation?
    
    private var willHide = false
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white:0.0, alpha:0.25)
        view.alpha = 0.0
        return view
    }()
    
    internal init(frameView: UIActivityIndicatorView = UIActivityIndicatorView(style: .whiteLarge)) {
        
        self.spinner = frameView
        super.init(frame: CGRect.zero)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        spinner = UIActivityIndicatorView(style: .whiteLarge)
        spinner.color = .black
        
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = .clear
        
        addSubview(backgroundView)
        addSubview(spinner)
        
    }
    
    internal override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundView.frame = bounds
    }
    ///The spinner position on the screen is taken care here.
    func showFrameView() {
        
        layer.removeAllAnimations()
        
        if let location = location {
            spinner.centerY(to: self)
            
            switch location  {
            case .left:
                spinner.left(to: self, rightAnchor, offset: 20.0, priority: .required, isActive: true)
            case .center:
                spinner.centerX(to: self)
            case .right:
                spinner.right(to: self, rightAnchor, offset: -20.0, priority: .required, isActive: true)
            }
        } else {
            spinner.center = center
        }
        
        spinner.alpha = 1.0
        isHidden = false
        spinner.startAnimating()
        
        spinner.accessibilityTraits = UIAccessibilityTraits.none
        spinner.isAccessibilityElement = true
        //spinner.accessibilityLabel = NSLocalizedString(DisplayableText.processing, comment: DisplayableText.processing)
    }
    ///stops the animation and hides the spinner
    func hideFrameView() {
        spinner.alpha = 0.0
        isHidden = true
        spinner.stopAnimating()
    }
}

///Used to Show and Hide the Spinner
final class Spinner {
    ///shows the activity indicator at the center
    static func show(in view: UIView? = nil, location: SpinnerLocation = SpinnerLocation.center) {
        ActivitySpinner.sharedSpinner.show(in: view, location: location)
    }
    ///hides the activity indicator
    static func hide() {
        ActivitySpinner.sharedSpinner.hide()
    }
}


