import Foundation

protocol MovieServiceProtocol {
    func searchMovies(withQuery query: String, completion: @escaping (Result<[Movie], Error>) -> Void)
}

class MovieService: MovieServiceProtocol {
    
    func searchMovies(withQuery query: String, completion: @escaping (Result<[Movie], Error>) -> Void) {
        
        guard let apiKey = Constants.apiKey.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            completion(.failure(MovieServiceError.invalidAPIKey))
            return
        }
        
        let urlString = "\(Constants.urlPath)\(apiKey)&query=\(query)"
        guard let url = URL(string: urlString) else {
            completion(.failure(MovieServiceError.invalidURL))
            return
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(MovieServiceError.noData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let searchResponse = try decoder.decode(SearchResponse.self, from: data)
                let movies = searchResponse.results
                completion(.success(movies))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}

enum MovieServiceError: Error {
    case invalidAPIKey
    case invalidURL
    case noData
}

