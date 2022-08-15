//
//  LectureListViewModel.swift
//  Sloth
//
//  Created by Eojin on 2022/08/14.
//

import Foundation
import Combine

enum LectureListViewModelError: Error, Equatable {
    case lessonsFetch
}

enum LectureListViewModelState: Equatable {
    case loading
    case finishedLoading
    case error(LectureListViewModelError)
}

final class LectureListViewModel {
    @Published private(set) var lessons: [Lesson] = []
    @Published private(set) var state: LectureListViewModelState = .loading

    private let lectureListService: LectureListServiceProtocol
    private var bindings = Set<AnyCancellable>()

    init(lectureListService: LectureListServiceProtocol = LectureListService()) {
        self.lectureListService = lectureListService
    }

    func search() {
        fetchLessons()
    }

    func retrySearch() {
        fetchLessons()
    }
}

extension LectureListViewModel {
    private func fetchLessons() {
        state = .loading

        let getTodayLessonsCompletionHandler: (Subscribers.Completion<Error>) -> Void = { [weak self] completion in
            switch completion {
            case .failure:
                self?.state = .error(.lessonsFetch)
            case .finished:
                self?.state = .finishedLoading
            }
        }

        let getTodayLessonsValueHandler: (Lessons) -> Void = { [weak self] lessons in
            self?.lessons = lessons
        }

        lectureListService
            .get()
            .sink(
                receiveCompletion: getTodayLessonsCompletionHandler,
                receiveValue: getTodayLessonsValueHandler
            )
            .store(in: &bindings)
    }
}
