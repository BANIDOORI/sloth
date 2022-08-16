//
//  LectureListService.swift
//  Sloth
//
//  Created by user on 2022/08/14.
//

import Foundation
import Combine

//enum ServiceError: Error {
//    case url(URLError)
//    case urlRequest
//    case decode
//}

protocol LectureListServiceProtocol {
    func get() -> AnyPublisher<[Lesson], Error>
}

final class LectureListService: LectureListServiceProtocol {
    func get() -> AnyPublisher<[Lesson], Error> {
        var dataTask: URLSessionDataTask?

        let onSubscription: (Subscription) -> Void = { _ in dataTask?.resume() }
        let onCancel: () -> Void = { dataTask?.cancel() }

        return Future<[Lesson], Error> { [weak self] promise in
            promise(.success(self?.lessonDummy() ?? []))
//            guard let urlRequest = self?.getUrlRequest() else {
//                promise(.failure(ServiceError.urlRequest))
//                return
//            }
//
//            dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
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
//            }
        }
        .handleEvents(receiveSubscription: onSubscription, receiveCancel: onCancel)
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }

    private func getUrlRequest() -> URLRequest? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "slothbackend.hopto.org"
        components.path = "/api/lesson/list"
        guard let url = components.url else { return nil }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.allHTTPHeaderFields = [
            "Authorization": ""
        ]
        return urlRequest
    }

    private func lessonDummy() -> Lessons {
        return [Lesson(categoryName: Optional("드로잉"), currentProgressRate: Optional(100), endDate: Optional("2022-07-12"), goalProgressRate: Optional(100), isFinished: Optional(true), lessonID: Optional(203), lessonName: Optional("qqqwwwyy"), lessonStatus: Optional("PAST"), price: Optional(32000), remainDay: Optional(-35), presentNumber: nil, siteName: Optional("해커스"), startDate: Optional("2022-04-12"), totalNumber: Optional(16), untilTodayFinished: nil, untilTodayNumber: nil), Sloth.Lesson(categoryName: Optional("공예"), currentProgressRate: Optional(100), endDate: Optional("2022-08-11"), goalProgressRate: Optional(100), isFinished: Optional(false), lessonID: Optional(213), lessonName: Optional("코루틴 deep dive"), lessonStatus: Optional("PAST"), price: Optional(32000), remainDay: Optional(-5), presentNumber: nil, siteName: Optional("테스트 사이트"), startDate: Optional("2022-05-11"), totalNumber: Optional(8), untilTodayFinished: nil, untilTodayNumber: nil), Sloth.Lesson(categoryName: Optional("직무교육"), currentProgressRate: Optional(6), endDate: Optional("2022-08-13"), goalProgressRate: Optional(100), isFinished: Optional(false), lessonID: Optional(259), lessonName: Optional("DD"), lessonStatus: Optional("PAST"), price: Optional(0), remainDay: Optional(-3), presentNumber: nil, siteName: Optional("유튜브"), startDate: Optional("2022-06-13"), totalNumber: Optional(32), untilTodayFinished: nil, untilTodayNumber: nil), Sloth.Lesson(categoryName: Optional("데이터"), currentProgressRate: Optional(1), endDate: Optional("2022-07-14"), goalProgressRate: Optional(100), isFinished: Optional(false), lessonID: Optional(261), lessonName: Optional("ㅇㅇ"), lessonStatus: Optional("PAST"), price: Optional(32000), remainDay: Optional(-33), presentNumber: nil, siteName: Optional("유튜브"), startDate: Optional("2022-06-14"), totalNumber: Optional(62), untilTodayFinished: nil, untilTodayNumber: nil), Sloth.Lesson(categoryName: Optional("직무교육"), currentProgressRate: Optional(100), endDate: Optional("2022-07-18"), goalProgressRate: Optional(100), isFinished: Optional(true), lessonID: Optional(281), lessonName: Optional("테스트"), lessonStatus: Optional("PAST"), price: Optional(0), remainDay: Optional(-29), presentNumber: nil, siteName: Optional("테스트 사이트"), startDate: Optional("2022-07-11"), totalNumber: Optional(4), untilTodayFinished: nil, untilTodayNumber: nil), Sloth.Lesson(categoryName: Optional("외국어"), currentProgressRate: Optional(100), endDate: Optional("2022-07-18"), goalProgressRate: Optional(100), isFinished: Optional(true), lessonID: Optional(282), lessonName: Optional("ㅇㅇ"), lessonStatus: Optional("PAST"), price: Optional(0), remainDay: Optional(-29), presentNumber: nil, siteName: Optional("유튜브"), startDate: Optional("2022-07-11"), totalNumber: Optional(4), untilTodayFinished: nil, untilTodayNumber: nil), Sloth.Lesson(categoryName: Optional("외국어"), currentProgressRate: Optional(0), endDate: Optional("2022-07-25"), goalProgressRate: Optional(100), isFinished: Optional(false), lessonID: Optional(283), lessonName: Optional("ㅇㅇ"), lessonStatus: Optional("PAST"), price: Optional(0), remainDay: Optional(-22), presentNumber: nil, siteName: Optional("유튜브"), startDate: Optional("2022-07-18"), totalNumber: Optional(32), untilTodayFinished: nil, untilTodayNumber: nil), Sloth.Lesson(categoryName: Optional("개발"), currentProgressRate: Optional(0), endDate: Optional("2022-08-20"), goalProgressRate: Optional(0), isFinished: Optional(false), lessonID: Optional(297), lessonName: Optional("string"), lessonStatus: Optional("CURRENT"), price: Optional(0), remainDay: Optional(4), presentNumber: nil, siteName: Optional("패스트캠퍼스"), startDate: Optional("2022-08-15"), totalNumber: Optional(0), untilTodayFinished: nil, untilTodayNumber: nil)]
    }
}
