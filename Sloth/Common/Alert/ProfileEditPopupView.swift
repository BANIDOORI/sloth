//
//  ProfileEditPopupView.swift
//  Sloth
//
//  Created by 심지원 on 2022/08/16.
//

import UIKit

final class ProfileEditPopupView: PopupView {
    var onEditted: ((_ name: String) -> ())?
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 32
        stackView.addArrangedSubviews(
            views: [
                profileButtonContainerView,
                nameTextField,
                divider,
                confirmButton
            ]
        )
        return stackView
    }()
    
    private lazy var profileButtonContainerView = UIView()
    
    private lazy var profileImageButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage.profile, for: .normal)
        button.contentMode = .center
        button.addTarget(
            self,
            action: #selector(handleConfirmButtonTapped),
            for: .touchUpInside
        )
        return button
    }()
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 16, weight: .regular)
        textField.textColor = .gray600
        textField.textAlignment = .left
        return textField
    }()
    
    private let divider: UIView = {
        let view = UIView()
        view.backgroundColor = .gray300
        return view
    }()
    
    private lazy var confirmButton: ConfirmButton = {
        let button = ConfirmButton()
        button.setTitle("완료", for: .normal)
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
        addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(24)
            $0.top.bottom.equalToSuperview().inset(40)
        }
        
        profileButtonContainerView.addSubview(profileImageButton)
        profileButtonContainerView.snp.makeConstraints {
            $0.height.equalTo(80)
        }
        profileImageButton.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.width.equalTo(profileImageButton.snp.height)
            $0.centerX.equalToSuperview()
        }
        
        nameTextField.snp.makeConstraints {
            $0.height.equalTo(22)
        }
        
        stackView.setCustomSpacing(8, after: nameTextField)
        
        divider.snp.makeConstraints {
            $0.height.equalTo(1)
        }
        
        confirmButton.snp.makeConstraints {
            $0.height.equalTo(48)
        }
    }
    
    @objc private func handleConfirmButtonTapped() {
        guard let nameText = nameTextField.text else {
            return
        }
        // TODO: NEED TO HANDLE 
        onEditted?(nameText)
    }
}
