//
//  TodayViewController.swift
//  Sloth
//
//  Created by 심지원 on 2022/05/08.
//

import UIKit
import SnapKit

class TodayViewController: UIViewController {
    
    weak var navigator: TodayViewNavigatorDelegate?
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("HIHI", for: .normal)
        button.addTarget(self, action: #selector(didButtonTap), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        
        view.addSubview(button)
        button.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
    }
    
    @objc private func didButtonTap() {
        navigator?.showMyPage()
    }
}
