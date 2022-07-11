//
//  UIAlertController+Extension.swift
//  Sloth
//
//  Created by 심지원 on 2022/07/10.
//

import UIKit

struct AlertActionModel {
    let title: String
    let action: () -> ()
    let type: UIAlertAction.Style
    
    init(title: String,
         type: UIAlertAction.Style = .default,
         action: @escaping () -> ()) {
        self.title = title
        self.action = action
        self.type = type
    }
}

extension UIAlertController {
    func addActions(with models: [AlertActionModel]){
        for action in models {
            let alertAction = UIAlertAction(title: action.title, style: action.type, handler: { _ in action.action() })
            addAction(alertAction)
        }
    }
}
