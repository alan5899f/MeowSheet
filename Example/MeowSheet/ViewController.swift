//
//  ViewController.swift
//  MeowSheet
//
//  Created by alan5899f on 01/24/2025.
//  Copyright (c) 2025 alan5899f. All rights reserved.
//

import UIKit
import SnapKit
import MeowSheet

class ViewController: UIViewController {
    
    private lazy var btnVC2: UIButton = {
        let button = UIButton()
        button.setTitle("Show VC2", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(didTapHandle), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        
        setupLayout()
    }
    
    private func setupLayout() {
        view.addSubview(btnVC2)
        btnVC2.snp.makeConstraints({
            $0.center.equalToSuperview()
            $0.width.equalTo(100)
            $0.height.equalTo(50)
        })
    }
    
    @objc private func didTapHandle() {
        let vc = ViewController2()
        presentMeowSheet(controller: vc)
    }
}

// MARK: - UIViewControllerTransitioningDelegate
extension ViewController: PresentationDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let presentationController = PresentationController(presentedViewController: presented, presenting: presenting)
        presentationController.presentationType = .fixed(300)
        return presentationController
    }
}
