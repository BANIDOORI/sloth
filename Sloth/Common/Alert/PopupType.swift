//
//  PopupType.swift
//  Sloth
//
//  Created by 심지원 on 2022/08/21.
//

import Foundation

enum PopupType {
    case editProfile(onEditteded: (_ name: String) -> ())
    case deleteLecture(onDeleted: () -> (), onCanceled: (() -> ())?)
    case logout(onLoggedOut: () -> (), onCanceled: (() -> ())?)
    case signOut(onSignedOut: () -> (), onCanceled: (() -> ())?)
}
