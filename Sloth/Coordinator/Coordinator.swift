//
//  Coordinator.swift
//  Sloth
//
//  Created by 심지원 on 2022/05/08.
//

import Foundation

protocol Coordinator: AnyObject {
    var children: [Coordinator] { get set }
    var router: Router { get }
    func present(animated: Bool, onDismissed: (() -> Void)?)
    func present(child: Coordinator, animated: Bool)
    func dismiss(animated: Bool, completion: (() -> ())?)
}

extension Coordinator {
    func present(child: Coordinator, animated: Bool) {
        children.append(child)
        child.present(animated: animated) { [weak self, weak child] in
            guard let self = self, let child = child else { return }
            self.removeChild(child)
        }
    }
    
    func dismiss(animated: Bool, completion: (() -> ())?) {
        router.dismiss(animated: animated)
        completion?()
    }
    
    private func removeChild(_ child: Coordinator) {
        guard let index = children.firstIndex(where: { $0 === child }) else { return }
        children.remove(at: index)
    }
}
