//
//  InformationAgreementViewController.swift
//  Sloth
//
//  Created by 심지원 on 2022/07/10.
//

import UIKit

class InformationAgreementViewController: UIViewController {
    struct Constraints {
        static let bottomPadding: CGFloat = 26
    }
    
    var navigator: InformationAgreementNavigator?
    
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
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 24
        stackView.addArrangedSubviews(views: [titleLabel, policyButton, buttonStackView])
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "나나공을 이용하시려면\n개인정보 동의가 필요해요"
        label.textAlignment = .left
        label.textColor = .gray600
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    private let policyButton: UIButton = {
        let button = UIButton()
        button.contentHorizontalAlignment = .left
        let attributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .medium),
            NSAttributedString.Key.foregroundColor: UIColor.gray400,
            NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue,
            NSAttributedString.Key.underlineColor: UIColor.gray400
        ]
        
        let attributeString = NSMutableAttributedString(
            string: "‘나나공’ 서비스 개인정보 처리 방침",
            attributes: attributes
        )
        button.setAttributedTitle(attributeString, for: .normal)
        
        return button
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 13
        stackView.addArrangedSubviews(views: [cancelButton, startButton])
        return stackView
    }()
    
    private lazy var cancelButton: CancelButton = {
        let button = CancelButton()
        button.setTitle("취소", for: .normal)
        button.addTarget(self, action: #selector(handleCancelButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var startButton: ConfirmButton = {
        let button = ConfirmButton()
        button.setTitle("동의하고 시작하기", for: .normal)
        button.addTarget(self, action: #selector(handleStartButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeViews()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        contentView.snp.updateConstraints {
            $0.height.equalTo(stackView.frame.height + Constraints.bottomPadding * 2)
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
        
        buttonStackView.snp.makeConstraints {
            $0.height.equalTo(56)
        }
    }
    
    @objc private func handleCancelButtonTapped() {
        navigator?.dismiss()
    }
    
    @objc private func handleStartButtonTapped() {
        // NOTE: NEED TO UPDATE
        navigator?.dismiss()
    }
}
