//
//  WarningPopupView.swift
//  Sloth
//
//  Created by 심지원 on 2022/08/16.
//

import UIKit

final class WarningPopupView: PopupView {
    var onConfirmed: (() -> ())?
    var onCanceled: (() -> ())?
    
    var message: String? {
        didSet {
            messageLabel.text = message
        }
    }
    
    var cancelButtonText: String = "취소" {
        didSet {
            cancelButton.setTitle(cancelButtonText, for: .normal)
        }
    }
    
    var confirmButtonText: String? {
        didSet {
            confirmButton.setTitle(confirmButtonText, for: .normal)
        }
    }
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 20
        stackView.addArrangedSubviews(
            views: [
                errorIconContainerView,
                messageLabel,
                buttonsStackView
            ]
        )
        return stackView
    }()
    
    private lazy var errorIconContainerView: UIView = {
        let view = UIView()
        view.addSubview(errorIconImageView)
        errorIconImageView.snp.makeConstraints { $0.edges.equalToSuperview() }
        return view
    }()
    
    private let errorIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .alertError
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    private lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 10
        stackView.addArrangedSubviews(
            views: [
                cancelButton,
                confirmButton
            ]
        )
        return stackView
    }()
    
    private lazy var cancelButton: CancelButton = {
        let button = CancelButton()
        button.setTitle(cancelButtonText, for: .normal)
        button.addTarget(self, action: #selector(handleCancelButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var confirmButton: ConfirmButton = {
        let button = ConfirmButton()
        button.activeBackgroundColor = .error
        button.setTitle(confirmButtonText, for: .normal)
        button.addTarget(self, action: #selector(handleConfirmButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initializeViews() {
        backgroundColor = .white
        layer.cornerRadius = 20
        addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(24)
            $0.top.equalToSuperview().inset(27)
            $0.bottom.equalToSuperview().inset(24)
        }
        
        errorIconContainerView.snp.makeConstraints {
            $0.height.equalTo(30)
        }
        
        messageLabel.snp.makeConstraints {
            $0.height.equalTo(25)
        }
        
        buttonsStackView.snp.makeConstraints {
            $0.height.equalTo(56)
        }
    }
    
    @objc private func handleCancelButtonTapped() {
        onCanceled?()
    }
    
    @objc private func handleConfirmButtonTapped() {
        onConfirmed?()
    }
}
