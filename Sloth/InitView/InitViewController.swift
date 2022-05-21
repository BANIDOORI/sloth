//
//  InitViewController.swift
//  Sloth
//
//  Created by 심지원 on 2022/05/19.
//

import UIKit

class InitViewController: UIViewController {
    private lazy var button: ConfirmButton = {
        let button = ConfirmButton()
        button.setTitle("나나공 시작하기", for: .normal)
        button.addTarget(self, action: #selector(handleButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeViews()
    }
    
    private func initializeViews() {
        view.addSubview(button)
        button.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview().inset(24)
            $0.height.equalTo(56)
        }
    }
    
    @objc private func handleButtonTapped() {
        
    }
}
