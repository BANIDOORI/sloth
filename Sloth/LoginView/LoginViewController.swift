//
//  LoginViewController.swift
//  Sloth
//
//  Created by 심지원 on 2022/05/21.
//

import UIKit

class LoginViewController: UIViewController {
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 8
        return stackView
    }()
    
    private lazy var googleLoginButton: UIButton = {
       let button = UIButton()
        button.setImage(.Login.google, for: .normal)
        button.addTarget(self, action: #selector(handleGoogleLoginTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var kakaoLoginButton: UIButton = {
       let button = UIButton()
        button.setImage(.Login.kakao, for: .normal)
        button.addTarget(self, action: #selector(handleKakaoLoginTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var appleLoginButton: UIButton = {
       let button = UIButton()
        button.setImage(.Login.apple, for: .normal)
        button.addTarget(self, action: #selector(handleAppleLoginTapped), for: .touchUpInside)
        return button
    }()
    
    
    private let viewModel: LoginViewModel
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeViews()
    }
    
    private func initializeViews() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(googleLoginButton)
        stackView.addArrangedSubview(kakaoLoginButton)
        stackView.addArrangedSubview(appleLoginButton)
        stackView.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(30)
            $0.bottom.equalToSuperview().inset(26)
        }
        googleLoginButton.snp.makeConstraints {
            $0.height.equalTo(50)
        }
    }
    
    
    @objc private func handleGoogleLoginTapped() {
        
    }
    
    @objc private func handleKakaoLoginTapped() {
        viewModel.loginWithKakao()
    }
    
    @objc private func handleAppleLoginTapped() {
        viewModel.loginWithApple()
    }
}
