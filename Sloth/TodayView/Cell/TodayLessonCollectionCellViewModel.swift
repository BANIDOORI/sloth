//
//  TodayLessonCollectionCellViewModel.swift
//  Sloth
//
//  Created by Eojin on 2022/05/14.
//

import Foundation
import Combine

final class TodayLessonCollectionCellViewModel {
    @Published var lessonName: String? = ""

    private let lesson: Lesson

    init(lesson: Lesson) {
        self.lesson = lesson

        setUpBindings()
    }

    private func setUpBindings() {
        lessonName = lesson.lessonName
    }
}
