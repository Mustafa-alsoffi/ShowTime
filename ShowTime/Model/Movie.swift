//
//  Movie.swift
//  ShowTime
//
//  Created by Mustafa Alsoffi on 26/05/2019.
//  Copyright © 2019 Mustafa Alsoffi. All rights reserved.
//

import Foundation


public struct MoviesResponse: Codable {
    
    public let page: Int
    public let totalResults: Int
    public let totalPages: Int
    public let results: [Movie]
}
public struct Movie: Codable {
    
    public let id: Int
    public let title: String
    public let overview: String
    public let releaseDate: Date
    public let voteAverage: Double
    public let voteCount: Int
    public let adult: Bool
    public let posterPath: String
}


public struct TVResponse: Codable {
    
    public let page: Int
    public let totalResults: Int
    public let totalPages: Int
    public let results: [Tv]
}

public struct Tv: Codable {
    
    public let id: Int
    public let overview: String
    public let voteAverage: Double
    public let voteCount: Int
    public let posterPath: String
    public let name: String
    public let firstAirDate: String
}
