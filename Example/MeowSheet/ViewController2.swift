//
//  ViewController2.swift
//  MeowSheet
//
//  Created by 陳韋綸 on 2025/1/26.
//  Copyright © 2025 CocoaPods. All rights reserved.
//

import UIKit
import SnapKit

class ViewController2: UIViewController {

    private lazy var squardView: UIView = {
        let view = UIView()
        view.backgroundColor = .brown
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        
        setupLayout()
    }
    
    private func setupLayout() {
        view.addSubview(squardView)
        squardView.snp.makeConstraints({
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(50)
        })
    }
}
