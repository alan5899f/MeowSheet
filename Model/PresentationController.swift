//
//  Presne.swift
//  MeowSheet
//
//  Created by 陳韋綸 on 2025/1/24.
//

import UIKit

public class PresentationController: UIPresentationController {

    // MARK: - Public Propertices
    /// Drag up or down with the controller and dismiss operate is enable.
    /// Default is true.
    public var enablePresentedViewDismissal: Bool = true {
        didSet {
            presentedView?.isUserInteractionEnabled = enablePresentedViewDismissal
        }
    }
    /// Tap background and dismiss operate  is enable.
    /// Default is true.
    public var enableBackgroundDismissal: Bool = true {
        didSet {
            backgroundView.isUserInteractionEnabled = enableBackgroundDismissal
        }
    }
    /// ContentView grabber show.
    /// Default is true.
    public var showPresentationGrabber: Bool = true {
        didSet {
            presentedPrefersGrabber.isHidden = !showPresentationGrabber
        }
    }
    /// Background color alpha.
    /// Default is 0.3.
    public var presentationBackgroundAlpha: CGFloat = 0.3 {
        didSet {
            backgroundView.alpha = presentationBackgroundAlpha
        }
    }
    /// Present custom sheet height.
    /// Default is percentage in max.
    public var presentationType: PresentationType = .percentage(1)
    
    // MARK: - Private Propertices
    private var pointOrigin: CGPoint?
    
    // MARK: - SubViews
    private lazy var presentedPrefersGrabber: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 2.5
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowRadius = 8
        view.layer.opacity = 0.3
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = !showPresentationGrabber
        return view
    }()

    private lazy var presentedContentView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var backgroundView: UIView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.isUserInteractionEnabled = enableBackgroundDismissal
        blurEffectView.alpha = presentationBackgroundAlpha
        return blurEffectView
    }()
    
    // MARK: - Life Cycle
    public override init(
        presentedViewController: UIViewController,
        presenting presentingViewController: UIViewController?
    ) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        setupPresentedViewLayout()
        setupPresentedViewGesture()
    }
    
    // MARK: - Layout
    private func setupPresentedViewLayout() {
        presentedView?.addSubview(presentedPrefersGrabber)
        presentedView?.addSubview(presentedContentView)
        presentedView?.sendSubviewToBack(presentedContentView)
        
        presentedPrefersGrabber.topAnchor.constraint(equalTo: presentedView!.topAnchor).isActive = true
        presentedPrefersGrabber.centerXAnchor.constraint(equalTo: presentedView!.centerXAnchor).isActive = true
        presentedPrefersGrabber.heightAnchor.constraint(equalToConstant: 5).isActive = true
        presentedPrefersGrabber.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        presentedContentView.topAnchor.constraint(equalTo: presentedView!.topAnchor).isActive = true
        presentedContentView.leadingAnchor.constraint(equalTo: presentedView!.leadingAnchor).isActive = true
        presentedContentView.trailingAnchor.constraint(equalTo: presentedView!.trailingAnchor).isActive = true
        presentedContentView.bottomAnchor.constraint(equalTo: presentedView!.bottomAnchor).isActive = true

        presentedPrefersGrabber.transform = CGAffineTransform(translationX: 0, y: -12)
    }
    
    // MARK: - GestureRecognizer
    private func setupPresentedViewGesture() {
        let presentedViewGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction))
        presentedView?.addGestureRecognizer(presentedViewGesture)
        
        let blurEffectGesture = UITapGestureRecognizer(target: self, action: #selector(dismissController))
        backgroundView.addGestureRecognizer(blurEffectGesture)
    }
}

// MARK: - public override Method
public extension PresentationController {
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView else { return .zero }
        switch presentationType {
        case .percentage(let percentage):
            let origin = CGPoint(x: 0, y: containerView.frame.height * (1 - percentage))
            let size = CGSize(width: containerView.frame.width, height: containerView.frame.height * percentage)
            return CGRect(origin: origin, size: size)
        case .fixed(let fixed):
            let origin = CGPoint(x: 0, y: (UIScreen.main.bounds.height - fixed))
            let size = CGSize(width: containerView.frame.width, height: fixed)
            return CGRect(origin: origin, size: size)
        }
    }

    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        containerView?.addSubview(backgroundView)
    }

    override func dismissalTransitionWillBegin() {
        super.dismissalTransitionWillBegin()
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { [weak self] UIViewControllerTransitionCoordinatorContext in
            guard let self else { return }
            backgroundView.alpha = 0
        }, completion: { [weak self] UIViewControllerTransitionCoordinatorContext in
            guard let self else { return }
            backgroundView.removeFromSuperview()
        })
    }

    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
    }

    override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        presentedView?.frame = frameOfPresentedViewInContainerView
        backgroundView.frame = containerView!.bounds
        pointOrigin = presentedView?.frame.origin
    }
}

// MARK: - Private Method
private extension PresentationController {
    @objc func panGestureRecognizerAction(sender: UIPanGestureRecognizer) {

        guard let pointOrigin else { return }
        
        let translation = sender.translation(in: presentedView)

        if translation.y <= 0 { return }

        UIViewPropertyAnimator(duration: 0.1, curve: .linear) { [weak self] in
            guard let self = self else { return }
            self.presentedView?.frame.origin = CGPoint(x: 0, y: pointOrigin.y + translation.y)
        }.startAnimation()

        if sender.state == .ended {
            let dragTranslation = sender.translation(in: presentedView)
            let dragVelocity = sender.velocity(in: presentedView)
            if dragTranslation.y >= 200 || dragVelocity.y >= 200 {
                dismissController()
            } else {
                UIViewPropertyAnimator(duration: 0.1, curve: .linear) { [weak self] in
                    guard let self = self else { return }
                    self.presentedView?.frame.origin = CGPoint(x: 0, y: pointOrigin.y)
                }.startAnimation()
            }
        }
    }

    @objc func dismissController() {
        presentedViewController.dismiss(animated: true, completion: nil)
    }
}
