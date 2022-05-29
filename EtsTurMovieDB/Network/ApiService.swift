//
//  ApiService.swift
//  EtsTurMovieDB
//

import Foundation
import Alamofire

protocol ServiceProtocol {
    
    func fetchTvSeries(completion: @escaping (_ success: Bool,_  result: TvShowList) -> ())
    func searchTvSeries(query: String, completion: @escaping (_ success: Bool,_  result: TvShowList) -> ())
}

class ApiService: ServiceProtocol {
    
    func fetchTvSeries(completion: @escaping (Bool, TvShowList) -> ()) {
        
        DispatchQueue.global().async {
            AF.request("\(Constants.fetchBaseUrl)api_key=\(Constants.apiKey)&language=tr-TR&page=1", method: .get).responseDecodable(of: TvShowList.self) { (response) in
                switch response.result {
                case let .success(data):
                    completion(true, data)
                case let .failure(error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func searchTvSeries(query: String, completion: @escaping (Bool, TvShowList) -> ()) {
        
        DispatchQueue.global().async {
            AF.request("\(Constants.searchUrl)api_key=\(Constants.apiKey)&language=tr-TR&page=1&query=\(query)", method: .get).responseDecodable(of: TvShowList.self) { (response) in
                switch response.result {
                case let .success(data):
                    completion(true, data)
                case let .failure(error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
