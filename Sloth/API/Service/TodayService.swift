//
//  TodayService.swift
//  Sloth
//
//  Created by Eojin on 2022/05/14.
//

import Foundation
import Combine

enum ServiceError: Error {
    case url(URLError)
    case urlRequest
    case decode
}

protocol TodayServiceProtocol {
    func get() -> AnyPublisher<[Lesson], Error>
}

final class TodayService: TodayServiceProtocol {
    func get() -> AnyPublisher<[Lesson], Error> {
        var dataTask: URLSessionDataTask?

        let onSubscription: (Subscription) -> Void = { _ in dataTask?.resume() }
        let onCancel: () -> Void = { dataTask?.cancel() }

        return Future<[Lesson], Error> { [weak self] promise in
            guard let urlRequest = self?.getUrlRequest() else {
                promise(.failure(ServiceError.urlRequest))
                return
            }

            dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
                promise(.success(self?.lessonDummy() ?? []))
//                guard let data = data else {
//                    if let error = error {
//                        promise(.failure(error))
//                    }
//                    return
//                }
//                do {
//                    let lessons = try JSONDecoder().decode(Lessons.self, from: data)
//                    promise(.success(lessons))
//                } catch {
//                    promise(.failure(ServiceError.decode))
//                }
            }
        }
        .handleEvents(receiveSubscription: onSubscription, receiveCancel: onCancel)
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }

    private func getUrlRequest() -> URLRequest? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "slothbackend.hopto.org"
        components.path = "/api/lesson/doing"
        guard let url = components.url else { return nil }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.allHTTPHeaderFields = [
            "Authorization": ""
        ]
        return urlRequest
    }

    private func lessonDummy() -> Lessons {
        return [
            Lesson(categoryName: "개발", currentProgressRate: nil, endDate: nil, goalProgressRate: nil, isFinished: nil, lessonID: 297, lessonName: "프로그래밍 시작하기 : 파이썬 입문 (Inflearn Original)1", lessonStatus: nil, price: nil, remainDay: 4, presentNumber: 0, siteName: "패스트캠퍼스", startDate: nil, totalNumber: 0, untilTodayFinished: true, untilTodayNumber: 0),
            Lesson(categoryName: "개발", currentProgressRate: nil, endDate: nil, goalProgressRate: nil, isFinished: nil, lessonID: 297, lessonName: "프로그래밍 시작하기 : 파이썬 입문 (Inflearn Original)2", lessonStatus: nil, price: nil, remainDay: 5, presentNumber: 0, siteName: "패스트캠퍼스", startDate: nil, totalNumber: 0, untilTodayFinished: false, untilTodayNumber: 0),
            Lesson(categoryName: "개발", currentProgressRate: nil, endDate: nil, goalProgressRate: nil, isFinished: nil, lessonID: 297, lessonName: "프로그래밍 시작하기 : 파이썬 입문 (Inflearn Original)3", lessonStatus: nil, price: nil, remainDay: 6, presentNumber: 0, siteName: "패스트캠퍼스", startDate: nil, totalNumber: 0, untilTodayFinished: true, untilTodayNumber: 0),
            Lesson(categoryName: "개발", currentProgressRate: nil, endDate: nil, goalProgressRate: nil, isFinished: nil, lessonID: 297, lessonName: "프로그래밍 시작하기 : 파이썬 입문 (Inflearn Original)4", lessonStatus: nil, price: nil, remainDay: 7, presentNumber: 0, siteName: "패스트캠퍼스", startDate: nil, totalNumber: 0, untilTodayFinished: false, untilTodayNumber: 0),
            Lesson(categoryName: "개발", currentProgressRate: nil, endDate: nil, goalProgressRate: nil, isFinished: nil, lessonID: 297, lessonName: "프로그래밍 시작하기 : 파이썬 입문 (Inflearn Original)5", lessonStatus: nil, price: nil, remainDay: 8, presentNumber: 0, siteName: "패스트캠퍼스", startDate: nil, totalNumber: 0, untilTodayFinished: true, untilTodayNumber: 0),
        ]
    }
}
