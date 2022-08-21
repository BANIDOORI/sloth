//
//  BaseViewController.swift
//  Sloth
//
//  Created by 심지원 on 2022/08/18.
//

import UIKit

class BaseViewController: UIViewController {
    
    // MARK: Properties for Popup
    
    private var popupBackgroundView: UIView?
    
    private var profileEditPopupView: ProfileEditPopupView?
    
    private var warningPopupView: WarningPopupView?
    
    private var popupAnimationFadingScale: CGFloat = 1.3
    private var popupAnimationDuration: TimeInterval = 0.2
    
}


// MARK: Actions for Popup
extension BaseViewController {
    
    
    open func showPopup(_ type: PopupType) {
        setupPopupBackgroundView()
        
        switch type {
        case .editProfile(let onEditteded):
            setupProfileEditPopupView(onEditteded)
        case .deleteLecture(let onDeleted, let onCanceled):
            setupLectureDeletePopupView(onDeleted: onDeleted, onCanceled: onCanceled)
        case .logout(let onLoggedOut, let onCanceled):
            setupLogoutPopupView(onLoggedOut: onLoggedOut, onCanceled: onCanceled)
        case .signOut(let onSignedOut, let onCanceled):
            setupSignOutPopupView(onSignedOut: onSignedOut, onCanceled: onCanceled)
        }
        
        fadeInPopupViews()
        showPopupViews()
    }
    
    open func dismissPopup() {
        let scale = popupAnimationFadingScale
        
        UIView.animate(
            withDuration: popupAnimationDuration,
            animations: {
                self.popupBackgroundView?.alpha = 0.0
                
                self.profileEditPopupView?.transform = .init(scaleX: scale, y: scale)
                self.profileEditPopupView?.alpha = 0.0
                
                self.warningPopupView?.transform = .init(scaleX: scale, y: scale)
                self.warningPopupView?.alpha = 0.0
            }, completion: { _ in
                self.popupBackgroundView?.removeFromSuperview()
                self.popupBackgroundView = nil
                
                self.profileEditPopupView?.removeFromSuperview()
                self.profileEditPopupView = nil
                
                self.warningPopupView?.removeFromSuperview()
                self.warningPopupView = nil
            }
        )
    }
    
    private func setupPopupBackgroundView() {
        guard popupBackgroundView == nil else { return }
        
        let popupBackgroundView = UIView()
        self.popupBackgroundView = popupBackgroundView
        popupBackgroundView.backgroundColor = .black.withAlphaComponent(0.72)
        
        navigationController?.view.addSubview(popupBackgroundView)
        popupBackgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setupProfileEditPopupView(_ onEditted: @escaping (String) -> ()) {
        guard profileEditPopupView == nil else { return }
        
        let profileEditPopupView = ProfileEditPopupView()
        self.profileEditPopupView = profileEditPopupView
        
        navigationController?.view.addSubview(profileEditPopupView)
        profileEditPopupView.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(32)
            $0.centerY.equalToSuperview()
        }
        
        profileEditPopupView.onEditted = onEditted
    }
    
    private func setupLectureDeletePopupView(
        onDeleted: @escaping () -> (),
        onCanceled: (() -> ())?
    ) {
        guard warningPopupView == nil else { return }
        
        let warningPopupView = WarningPopupView()
        self.warningPopupView = warningPopupView
        
        navigationController?.view.addSubview(warningPopupView)
        warningPopupView.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(32)
            $0.centerY.equalToSuperview()
        }
        
        warningPopupView.message = "한층 성장할 기회, 정말 포기할거야?"
        warningPopupView.confirmButtonText = "포기하기"
        warningPopupView.onConfirmed = onDeleted
        warningPopupView.onCanceled = onCanceled
    }
    
    private func setupLogoutPopupView(
        onLoggedOut: @escaping () -> (),
        onCanceled: (() -> ())?
    ) {
        guard warningPopupView == nil else { return }
        
        let warningPopupView = WarningPopupView()
        self.warningPopupView = warningPopupView
        
        navigationController?.view.addSubview(warningPopupView)
        warningPopupView.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(32)
            $0.centerY.equalToSuperview()
        }
        
        warningPopupView.message = "정말 로그아웃 하시겠습니까?"
        warningPopupView.confirmButtonText = "확인"
        warningPopupView.onConfirmed = onLoggedOut
        warningPopupView.onCanceled = onCanceled
    }
    
    private func setupSignOutPopupView(
        onSignedOut: @escaping () -> (),
        onCanceled: (() -> ())?
    ) {
        guard warningPopupView == nil else { return }
        
        let warningPopupView = WarningPopupView()
        self.warningPopupView = warningPopupView
        
        navigationController?.view.addSubview(warningPopupView)
        warningPopupView.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(32)
            $0.centerY.equalToSuperview()
        }
        
        warningPopupView.message = "회원을 탈퇴하시겠습니까?"
        warningPopupView.confirmButtonText = "확인"
        warningPopupView.onConfirmed = onSignedOut
        warningPopupView.onCanceled = onCanceled
    }
    
    private func fadeInPopupViews() {
        let scale = popupAnimationFadingScale
        popupBackgroundView?.alpha = 0.0
        
        profileEditPopupView?.alpha = 0.0
        profileEditPopupView?.transform = .init(scaleX: scale, y: scale)
        
        warningPopupView?.alpha = 0.0
        warningPopupView?.transform = .init(scaleX: scale, y: scale)
    }
    
    private func showPopupViews() {
        UIView.animate(withDuration: popupAnimationDuration) {
            self.popupBackgroundView?.alpha = 1.0
            
            self.profileEditPopupView?.alpha = 1.0
            self.profileEditPopupView?.transform = CGAffineTransform.identity
            
            self.warningPopupView?.alpha = 1.0
            self.warningPopupView?.transform = CGAffineTransform.identity
        }
    }
}
