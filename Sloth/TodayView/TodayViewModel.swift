//
//  TodayViewModel.swift
//  Sloth
//
//  Created by Eojin on 2022/05/14.
//

import Foundation
import Combine

enum TodayViewModelError: Error, Equatable {
    case lessonsFetch
}

enum TodayViewModelState: Equatable {
    case loading
    case finishedLoading
    case error(TodayViewModelError)
}

final class TodayViewModel {
    @Published private(set) var lessons: [Lesson] = []
    @Published private(set) var state: TodayViewModelState = .loading

    private let todayService: TodayServiceProtocol
    private var bindings = Set<AnyCancellable>()

    init(todayService: TodayServiceProtocol = TodayService()) {
        self.todayService = todayService
    }

    func search() {
        fetchLessons()
    }

    func retrySearch() {
        fetchLessons()
    }
}

extension TodayViewModel {
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

        todayService
            .get()
            .sink(
                receiveCompletion: getTodayLessonsCompletionHandler,
                receiveValue: getTodayLessonsValueHandler
            )
            .store(in: &bindings)
    }
}
