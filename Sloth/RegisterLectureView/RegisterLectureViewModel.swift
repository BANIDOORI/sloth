//
//  RegisterLectureViewModel.swift
//  Sloth
//
//  Created by 심지원 on 2022/05/15.
//

import Foundation

protocol RegisterLessonViewBinder {
    var lectureTitle: String? { get set }
    var lectureCount: String? { get set }
    var lectureCategory: LectureCategory? { get set }
    var lectureSite: LectureSite? { get set }
    
    func handleNextClicked(completion: @escaping (Bool) -> ())
}

class RegisterLectureViewModel: RegisterLessonViewBinder {
    var lectureTitle: String?
    var lectureCount: String?
    var lectureCategory: LectureCategory?
    var lectureSite: LectureSite?
    
    func handleNextClicked(completion: @escaping (Bool) -> ()) {
        let isNextPossible = checkIfFieldsAreValid()
        completion(isNextPossible)
    }
    
    private func checkIfFieldsAreValid() -> Bool {
        return true
    }
}

