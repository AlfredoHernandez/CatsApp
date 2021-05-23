//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

@testable import CatsApp
import CatsFoundation
import Combine
import XCTest

final class BreedsStoreTests: XCTestCase {
    func test_fetchBreeds_displaysLoaderAndStartsLoading() {
        let (sut, loader) = makeSUT()

        sut.fetchBreeds()

        XCTAssertTrue(sut.isLoading)
        XCTAssertEqual(loader.completions.count, 1)
    }

    func test_fetchBreeds_completesSuccessfullyAndStopsLoading() {
        let (sut, loader) = makeSUT()
        let breed0 = Breed(
            id: "any-id",
            name: "any name",
            origin: "origin 0",
            description: "description 0",
            temperament: "temperament 0",
            lifeSpan: "lifeSpan 0",
            adaptability: 0,
            affectionLevel: 1,
            childFriendly: 2,
            dogFriendly: 3,
            image: anyURL()
        )

        sut.fetchBreeds()
        loader.complete(with: [breed0], at: 0)

        XCTAssertFalse(sut.isLoading)
        XCTAssertEqual(sut.breeds.count, 1)
        XCTAssertEqual(sut.breeds.first?.name, breed0.name)
        XCTAssertEqual(sut.breeds.first?.url, breed0.image)
    }

    func test_fetchBreedsWithError_displaysErrorAndStopsLoading() {
        let (sut, loader) = makeSUT()

        sut.fetchBreeds()
        loader.complete(with: anyError(), at: 0)

        XCTAssertFalse(sut.isLoading)
    }

    // MARK: - Helpers

    private func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> (BreedStore, BreedLoaderSpy) {
        let loader = BreedLoaderSpy()
        let sut = BreedStore(loader: loader.publisher())
        trackForMemoryLeaks(loader, file: file, line: line)
        return (sut, loader)
    }

    private class BreedLoaderSpy {
        private(set) var completions = [PassthroughSubject<[Breed], Error>]()

        func publisher() -> AnyPublisher<[Breed], Error> {
            let publisher = PassthroughSubject<[Breed], Error>()
            completions.append(publisher)
            return publisher.eraseToAnyPublisher()
        }

        func complete(with breeds: [Breed], at index: Int) {
            completions[index].send(breeds)
        }

        func complete(with error: Error, at index: Int) {
            completions[index].send(completion: .failure(error))
        }
    }

    private func anyError() -> NSError {
        NSError(domain: "testing", code: 0, userInfo: nil)
    }

    func anyURL() -> URL {
        URL(string: "http://any-url.com")!
    }
}
