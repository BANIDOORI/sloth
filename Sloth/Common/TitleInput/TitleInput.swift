//
//  TitleInput.swift
//  Sloth
//
//  Created by 심지원 on 2022/05/15.
//

import UIKit

class TitleInput: UIView {
    // MARK: Title Label Properties
    var titleText: String? {
        didSet {
            titleLabel.text = titleText
        }
    }
    
    var titleTextAlign: NSTextAlignment = .left {
        didSet {
            titleLabel.textAlignment = titleTextAlign
        }
    }
    
    var titleTextColor: UIColor = .gray500 {
        didSet {
            titleLabel.textColor = titleTextColor
        }
    }
    
    var titleFont: UIFont = .systemFont(ofSize: 16, weight: .medium) {
        didSet {
            titleLabel.font = titleFont
        }
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = titleTextAlign
        label.textColor = titleTextColor
        label.font = titleFont
        return label
    }()
    
    // MARK: Input Container View Properties
    var borderWidth: CGFloat = 1 {
        didSet {
            inputContainerView.layer.borderWidth = borderWidth
        }
    }
    
    var borderColor: UIColor = .gray300 // inactive
    var errorBorderColor: UIColor? = .error
    var focusedBorderColor: UIColor? = .primary400
    
    var activatedBackgroundColor: UIColor? = .clear
    var disabledBackgroundColor: UIColor? = .gray300
    
    var cornerRadius: CGFloat = 10 {
        didSet {
            inputContainerView.layer.cornerRadius = cornerRadius
        }
    }
    
    lazy var inputContainerView: UIView = {
        let view = UIView()
        view.layer.borderColor = borderColor.cgColor
        view.layer.borderWidth = borderWidth
        view.layer.cornerRadius = cornerRadius
        view.backgroundColor = activatedBackgroundColor
        return view
    }()
    
    lazy var secondaryInputContainerView: UIView = {
        let view = UIView()
        view.layer.borderColor = borderColor.cgColor
        view.layer.borderWidth = borderWidth
        view.layer.cornerRadius = cornerRadius
        view.backgroundColor = activatedBackgroundColor
        return view
    }()
    
    private let inputStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 5
        return stackView
    }()
    
    // MARK: Text Field Properties
    var text: String? {
        didSet {
            textField.text = text
        }
    }
    
    var textFieldAlignment: NSTextAlignment = .left {
        didSet {
            textField.textAlignment = textFieldAlignment
        }
    }
    
    var textFieldFont: UIFont = .systemFont(ofSize: 16, weight: .regular) {
        didSet {
            textField.font = textFieldFont
        }
    }
    
    var placeholder: String? {
        didSet {
            textField.placeholder = placeholder
            secondaryTextField.placeholder = placeholder
        }
    }
    
    var textFieldColor: UIColor = .gray600 {
        didSet {
            textField.textColor = textFieldColor
        }
    }
    
    internal lazy var textField: UITextField = {
        let field = UITextField()
        field.textAlignment = textFieldAlignment
        field.font = textFieldFont
        field.placeholder = placeholder
        field.textColor = textFieldColor
        field.backgroundColor = .clear
        return field
    }()
    
    internal lazy var secondaryTextField: UITextField = {
        let field = UITextField()
        field.textAlignment = textFieldAlignment
        field.font = textFieldFont
        field.placeholder = placeholder
        field.textColor = textFieldColor
        field.backgroundColor = .clear
        return field
    }()
    
    // MARK: Right Icon Properties
    var rightIcon: UIImage? {
        didSet {
            rightIconImageView.image = rightIcon
        }
    }
    
    private let rightIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initializeViews() {
        addSubview(titleLabel)
        
        addSubview(inputContainerView)
        inputContainerView.addSubview(inputStackView)
        inputStackView.addArrangedSubviews(views: [textField, rightIconImageView])
        
        addSubview(secondaryInputContainerView)
        secondaryInputContainerView.addSubview(secondaryTextField)
        
        initializeConstraints()
    }
    
    private func initializeConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(22)
        }
        
        inputContainerView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.height.equalTo(56)
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
        }
        
        inputStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
        }
        
        rightIconImageView.snp.makeConstraints {
            $0.width.equalTo(24)
        }
        
        secondaryInputContainerView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalTo(inputContainerView.snp.bottom)
            $0.bottom.equalToSuperview()
        }
    }
    
    func activateSecondaryInput() {
        secondaryInputContainerView.snp.updateConstraints {
            $0.top.equalTo(inputContainerView.snp.bottom).offset(8)
        }
        secondaryTextField.isUserInteractionEnabled = true
        
        secondaryTextField.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
        }
    }
}
