//
//  TvShows.swift
//  EtsTurMovieDB
//
//

import Foundation

struct TvShowItem: Codable {
    
    var backdrop_path: String?
    var id: Int?
    var name: String?
    var overview: String?
    var first_air_date: String?
    var vote_average: Double?
    var poster_path: String?
    var original_language: String?
    
 
}

struct TvShowList: Codable {
    
    var page: Int?
    var results: [TvShowItem]
}


