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
                guard let data = data else {
                    if let error = error {
                        promise(.failure(error))
                    }
                    return
                }
                do {
                    let lessons = try JSONDecoder().decode(Lessons.self, from: data)
                    promise(.success(lessons))
                } catch {
                    promise(.failure(ServiceError.decode))
                }
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
        components.path = "/api/lesson/list"
        guard let url = components.url else { return nil }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.allHTTPHeaderFields = [
            "Authorization": "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJBQ0NFU1MiLCJhdWQiOiJzYXRsczM0QG5hdmVyLmNvbSIsImlhdCI6MTY1MjYwOTg0NiwiZXhwIjoxNjUyNjEwNzQ2fQ.AeixE0NdEC56pIQ06pNmf-sMLAGVhHCwlONhqyFagbM6PxhHUhCvXCAzjpxTvcblI3-loVi_DvwOz9bXkl3_nA"
        ]
        return urlRequest
    }
}
