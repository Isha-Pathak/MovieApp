import XCTest
@testable import MarianaTek

class MovieViewModelTests: XCTestCase {
    var movieServiceMock: MovieServiceMock!
    var movieViewModel: MovieViewModel!
    
    override func setUp() {
        super.setUp()
        movieServiceMock = MovieServiceMock()
        movieViewModel = MovieViewModel(movieService: movieServiceMock)
    }
    
    override func tearDown() {
        movieServiceMock = nil
        movieViewModel = nil
        super.tearDown()
    }
    
    func testSearchMovies_Success() {
        // Given
        let expectation = self.expectation(description: "Search movies completion called")
        let mockMovies: [Movie] = [
            Movie(title: "Movie 1", overview: "Overview 1", posterPath: nil),
            Movie(title: "Movie 2", overview: "Overview 2", posterPath: nil),
            Movie(title: "Movie 3", overview: "Overview 3", posterPath: nil)
        ]
        movieServiceMock.searchMoviesCompletionResult = .success(mockMovies)
        
        // When
        movieViewModel.searchMovies(withQuery: "batman") { result in
            // Then
            switch result {
            case .success(let movies):
                XCTAssertEqual(movies.count, mockMovies.count)
                XCTAssertEqual(movies, mockMovies)
            case .failure(_):
                XCTFail("Expected success, got failure")
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testSearchMovies_Failure() {
        // Given
        let expectation = self.expectation(description: "Search movies completion called")
        let expectedError = MovieServiceError.invalidURL
        movieServiceMock.searchMoviesCompletionResult = .failure(expectedError)
        
        // When
        movieViewModel.searchMovies(withQuery: "jdbjsbfd") { result in
            // Then
            switch result {
            case .success(_):
                XCTFail("Expected failure, got success")
            case .failure(let error):
                XCTAssertEqual(error as? MovieServiceError, expectedError)
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
}

class MovieServiceMock: MovieServiceProtocol {
    var searchMoviesCompletionResult: Result<[Movie], Error> = .failure(MovieServiceError.invalidAPIKey)
    
    func searchMovies(withQuery query: String, completion: @escaping (Result<[Movie], Error>) -> Void) {
        completion(searchMoviesCompletionResult)
    }
}


