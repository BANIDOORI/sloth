//
//  LoginViewController.swift
//  Sloth
//
//  Created by 심지원 on 2022/05/21.
//

import UIKit

class LoginViewController: UIViewController {
    struct Constraints {
        static let bottomPadding: CGFloat = 26
    }
    
    private var contentViewHeight: CGFloat {
        stackView.frame.height + Constraints.bottomPadding * 2
    }
    
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 30
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 8
        stackView.addArrangedSubviews(views: [titleLabel, googleLoginButton, kakaoLoginButton, appleLoginButton])
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "로그인 방법 선택"
        label.textColor = .gray600
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textAlignment = .center
        return label
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

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        contentView.snp.updateConstraints {
            $0.height.equalTo(contentViewHeight)
        }
    }

    private func initializeViews() {
        view.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.bottom.left.right.equalToSuperview()
            $0.height.equalTo(0)
        }
        
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(30)
            $0.bottom.equalToSuperview().inset(Constraints.bottomPadding)
        }
        googleLoginButton.snp.makeConstraints {
            $0.height.equalTo(50)
        }
    }
    
    @objc private func handleGoogleLoginTapped() {
        viewModel.loginWithGoogle()
    }
    
    @objc private func handleKakaoLoginTapped() {
        viewModel.loginWithKakao()
    }
    
    @objc private func handleAppleLoginTapped() {
        viewModel.loginWithApple()
    }
}
