//
//  PresentationDelegate.swift
//  Pods
//
//  Created by 陳韋綸 on 2025/1/27.
//

import UIKit

// MARK: - Present Interface Delegate
public protocol PresentationDelegate: UIViewControllerTransitioningDelegate {
    /// Integration code in method.
    /// You should call presentMeowSheet for you need present controller.
    func presentMeowSheet(controller: UIViewController)
}

// MARK: - Present Input Extension
public extension PresentationDelegate where Self: UIViewController {
    func presentMeowSheet(controller: UIViewController) {
        controller.modalPresentationStyle = .custom
        controller.transitioningDelegate = self
        self.present(controller, animated: true)
    }
}
