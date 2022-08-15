//
//  MainViewModel.swift
//  Sloth
//
//  Created by 심지원 on 2022/08/15.
//

import Foundation

final class MainViewModel: TodayViewNavigatorDelegate, LectureListNavigatorDelegate {
    func showMyPage() {
        
    }
    
    func showLectureRegister() {
        navigator?.showLectureRegister()
    }
    
    weak var navigator: MainViewNavigator?
}
