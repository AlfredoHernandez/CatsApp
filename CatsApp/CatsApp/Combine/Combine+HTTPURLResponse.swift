//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

import Combine
import Foundation

extension URLSession {
    func httpDataTaskPublisher<T>(for request: URLRequest, mapper: @escaping (Data, HTTPURLResponse) throws -> T) -> AnyPublisher<T, Error> {
        dataTaskPublisher(for: request)
            .tryMap { ($0, $1 as! HTTPURLResponse) }
            .tryMap(mapper)
            .eraseToAnyPublisher()
    }
}
