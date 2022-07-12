//
//  UIViewController+Extension.swift
//  Sloth
//
//  Created by 심지원 on 2022/07/10.
//

import UIKit

extension UIViewController {
    func presentActionSheet(
        title: String?,
        message: String?,
        actionTitles: [String],
        cancelTitle: String?,
        actionSelected: @escaping (Int) -> (),
        cancelAction: (() -> ())? = nil
    ) {
        var models: [AlertActionModel] = []
        for (i, actionTitle) in actionTitles.enumerated() {
            let model = AlertActionModel(title: actionTitle, action: {
                actionSelected(i)
            })
            models.append(model)
        }
        if let cancelTitle = cancelTitle {
            let cancelModel = AlertActionModel(title: cancelTitle, type: .cancel, action: {
                cancelAction?()
            })
            models.append(cancelModel)
        }
        presentAlert(title: title, message: message, style: .actionSheet, actions: models)
    }
    
    func presentAlert(
        title: String?,
        message: String?,
        style: UIAlertController.Style,
        actions: [AlertActionModel]
    ) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        alertController.addActions(with: actions)
        DispatchQueue.main.async {
            self.present(alertController, animated: true)
        }
    }
}
