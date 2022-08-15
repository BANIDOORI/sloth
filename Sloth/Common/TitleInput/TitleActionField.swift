//
//  TitleActionSheet.swift
//  Sloth
//
//  Created by 심지원 on 2022/05/15.
//

import UIKit

class TitleActionField: TitleField {
    var onAction: (() -> ())?
    
    private var tapGestureRecognizer: UITapGestureRecognizer!
    
    private let expandMoreImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = .expandMore
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAction()
        initializeViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showDirectInputField() {
        activateSecondaryInput()
    }
    
    private func setupAction() {
        textField.isUserInteractionEnabled = false
        self.isUserInteractionEnabled = true
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapped))
        addGestureRecognizer(tapGestureRecognizer)
        tapGestureRecognizer.delegate = self
    }
    
    private func initializeViews() {
        rightIcon = .expandMore
    }
    
    @objc private func handleTapped() {
        onAction?()
    }
}

extension TitleActionField: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        let p = touch.location(in: self)
        if secondaryInputContainerView.frame.contains(p) {
            return false
        }
        return true
    }
}

