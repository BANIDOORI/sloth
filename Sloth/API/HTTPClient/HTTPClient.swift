//
//  HTTPClient.swift
//  Sloth
//
//  Created by 심지원 on 2022/05/19.
//

import Foundation
import Combine

enum CommonError: Error {
    case authError
    case serverError
    case networkError
    case decodeError
    case unknown(Error)
}

protocol HTTPClient {
    func execute<ResponseType: Decodable>(
        request: URLRequest
    ) -> AnyPublisher<ResponseType, CommonError>
}

class HTTPClientImp: HTTPClient {
    
    func execute<ResponseType: Decodable>(
        request: URLRequest
    ) -> AnyPublisher<ResponseType, CommonError> {
        var dataTask: URLSessionDataTask?
        let onSubscription: (Subscription) -> Void = { _ in dataTask?.resume() }
        let onCancel: () -> Void = { dataTask?.cancel() }
        
        return Future<ResponseType, CommonError> { promise in
            dataTask = URLSession.shared.dataTask(with: request) { data, response, error   in
                guard let data = data else {
                    if let error = error {
                        promise(.failure(.unknown(error)))
                    }
                    return
                }
                
                do {
                    let decoded = try JSONDecoder().decode(ResponseType.self, from: data)
                    promise(.success(decoded)) 
                }
                catch {
                    promise(.failure(.decodeError))
                }
            }
        }
        .handleEvents(receiveSubscription: onSubscription, receiveOutput: nil, receiveCompletion: nil, receiveCancel: onCancel, receiveRequest: nil)
        .eraseToAnyPublisher()
    }
    
    func execute<ResponseType: Decodable, ConvertedType>(
        request: URLRequest,
        converter: @escaping (ResponseType) -> ConvertedType,
        completion: @escaping (Result<ConvertedType, CommonError>) -> ()
    ) {
        var request = request
        
        let headers = ["Content-Type": "application/json"]
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            self?.handleResponse(data: data, urlResponse: response, error: error, converter: converter, completion: completion)
        }
        session.resume()
    }
    
    private func handleResponse<ResponseType: Decodable, ConvertedType>(
        data: Data?,
        urlResponse: URLResponse?,
        error: Error?,
        converter: @escaping (ResponseType) -> ConvertedType,
        completion: @escaping (Result<ConvertedType, CommonError>) -> ()
    ) {
        if let error = getError(from: error) ?? getError(from: urlResponse) {
            completion(.failure(error))
            return
        }
        
        guard let data = data else {
            completion(.failure(.networkError))
            return
        }
        
        do {
            let response = try JSONDecoder().decode(ResponseType.self, from: data)
            let converted = converter(response)
            completion(.success(converted))
        }
        catch(let error) {
            print(error)
            let dataError = getError(from: data, urlResponse: urlResponse)
            completion(.failure(.unknown(dataError)))
        }
    }
    
    
    private func getError(from error: Error?) -> CommonError? {
        guard let err = error as NSError? else {
            return nil
        }
        if err.code == -1009 {
            return .networkError
        }
        return .unknown(err)
    }
    
    private func getError(from urlResponse: URLResponse?) -> CommonError? {
        guard let urlResponse = urlResponse as? HTTPURLResponse else {
            return nil
        }
        
        if 500...599 ~= urlResponse.statusCode {
            return .serverError
        }
        return nil
    }
    
    private func getError(from data: Data, urlResponse: URLResponse?) -> NSError {
        let json = String(data: data, encoding: .utf8) ?? ""
        let statusCode = (urlResponse as? HTTPURLResponse)?.statusCode ?? -1
        let error = NSError(domain: json, code: statusCode, userInfo: nil)
        return error
    }
}
