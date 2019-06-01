//
//  MovieServiceAPI.swift
//  ShowTime
//
//  Created by Mustafa Alsoffi on 26/05/2019.
//  Copyright © 2019 Mustafa Alsoffi. All rights reserved.
//

import Foundation

class MovieAPIService {
    
    public static let shared = MovieAPIService()
    private init() {}
    private let urlSession = URLSession.shared
    private let baseURL = URL(string: "https://api.themoviedb.org/3")!
    private let apiKey = "1191932350a10cfdd866b164e8b1e95c"
    private let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
        return jsonDecoder
    }()
    // Enum Endpoint
    enum Endpoint: String, CaseIterable {
        case nowPlaying = "now_playing"
        case upcoming
        case popular
        case topRated = "top_rated"
        
    }
    
    public enum APIServiceError: Error {
        case apiError
        case invalidEndpoint
        case invalidResponse
        case noData
        case decodeError
    }
    
   
    
    private func fetchResources<T: Decodable>(url: URL, completion: @escaping (Result<T, APIServiceError>) -> Void) {
        
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            completion(.failure(.invalidEndpoint))
            return
        }
        let queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
        urlComponents.queryItems = queryItems
        guard let url = urlComponents.url else {
            completion(.failure(.invalidEndpoint))
            return
        }


        self.urlSession.dataTask(with: url) { (result) in
            switch result {
            case .success(let (response, data)):
                
                guard let statusCode = (response as? HTTPURLResponse)?.statusCode, 200..<299 ~= statusCode
                    
                    else {

                    completion(.failure(.invalidResponse))
                    return
                }
                do {
                    
                    let values = try self.jsonDecoder.decode(T.self, from: data)
                    completion(.success(values))
                } catch {
                    completion(.failure(.decodeError))
                }
            case .failure( _):

                completion(.failure(.apiError))
            }
            }.resume()
        
       
    }
    
    public func fetchMovies(from endpoint: Endpoint, result: @escaping (Result<MoviesResponse, APIServiceError>) -> Void) {
        
        let movieURL = baseURL
            .appendingPathComponent("movie")
            .appendingPathComponent(endpoint.rawValue)
        fetchResources(url: movieURL, completion: result)
    }
    
//    public func fetchMovie(movieId: Int, result: @escaping (Result<Movie, APIServiceError>) -> Void) {
//        
//        let movieURL = baseURL
//            .appendingPathComponent("movie")
//            .appendingPathComponent(String(movieId))
//        fetchResources(url: movieURL, completion: result)
//    }
    
    
    public func fetchTvShows(from endpoint: Endpoint, result: @escaping (Result<TVResponse, APIServiceError>) -> Void) {
        
        let tvURL = baseURL
            .appendingPathComponent("tv")
            .appendingPathComponent(endpoint.rawValue)
        
   

      fetchResources(url: tvURL, completion: result)
                

    }
}
