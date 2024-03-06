//
//  NetworkingManager.swift
//  CryptoApp-SwiftUI
//
//  Created by Gorkem on 17.01.2024.
//

import Combine
import Foundation

protocol NetworkingManagerInterface {
    func download(url: URL) -> AnyPublisher<Data, Error>
    func handleCompletion(completion: Subscribers.Completion<Error>)
}

final class NetworkingManager: NetworkingManagerInterface {
    
    enum NetworkingError: LocalizedError {
        case badURLResponse(url: URL)
        case unknown
        
        var errorDescription: String? {
            switch self {
            case .badURLResponse(url: let url):
                return " [🔥] Bad response from URL: \(url)"
            case .unknown:
                return " [⚠️] Unknown error occured."
            }
        }
    }
    
    func download(url: URL) -> AnyPublisher<Data, Error>{
        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap({ try self.handleURLResponse(output: $0, url: url) })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw NetworkingError.badURLResponse(url: url)
        }
        return output.data
    }
    
    func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}
