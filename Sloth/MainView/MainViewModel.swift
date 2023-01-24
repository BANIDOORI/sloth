//
//  MainViewModel.swift
//  Sloth
//
//  Created by 심지원 on 2022/08/15.
//

import Foundation

final class MainViewModel: TodayViewNavigator, LectureListNavigator {
    
    func showLectureRegister() {
        navigator?.showLectureRegister()
    }
    
    func showLectureDetail() {
        navigator?.showLectureDetail()
    }

    weak var navigator: MainViewNavigator?
}
