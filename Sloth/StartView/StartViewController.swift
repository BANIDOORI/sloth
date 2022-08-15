//
//  StartViewController.swift
//  Sloth
//
//  Created by 심지원 on 2022/05/19.
//

import UIKit

class StartViewController: UIViewController {
    weak var navigator: StartNavigator?
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 12
        stackView.addArrangedSubviews(views: [titleLabel, descriptionLabel, illustImageView])
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .black
        label.font = .systemFont(ofSize: 28, weight: .bold)
        
        let fullString = "나보다 나무늘보가\n공부 열심히 한다"
        let color: UIColor = .primary400
        let attrsString =  NSMutableAttributedString(string: fullString)
        let range = NSRange(location: 0, length: (fullString as NSString).length)
        let regex = try! NSRegularExpression(pattern: "(나|공)", options: [])
        let matches = regex.matches(in: fullString, range: range)
        
        for match in matches {
            attrsString.addAttribute(
                NSAttributedString.Key.foregroundColor,
                value: color,
                range: match.range
            )
        }
        
        label.attributedText = attrsString
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "나무늘보도 못 이기나요?"
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = UIColor(red: 86/255, green: 86/255, blue: 86/255, alpha: 1)
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    private let illustImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.Sloth.login
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var loginButton: ConfirmButton = {
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
        view.backgroundColor = .white
        
        view.addSubview(loginButton)
        loginButton.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview().inset(48)
            $0.height.equalTo(56)
        }
        
        view.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(36)
            $0.top.equalToSuperview().inset(72)
            $0.bottom.equalTo(loginButton.snp.top).inset(-36)
        }
        
        titleLabel.snp.makeConstraints {
            $0.height.equalTo(78)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.height.equalTo(20)
        }
        
    }
    
    @objc private func handleButtonTapped() {
        navigator?.showMain()
    }
}
