//
//  ApiService.swift
//  EtsTurMovieDB
//

import Foundation
import Alamofire

protocol ServiceProtocol {
    
    func fetchTvSeries(completion: @escaping (_ success: Bool,_  result: TvShowList) -> ())
}

class ApiService: ServiceProtocol {
    
    let baseUrl = "https://api.themoviedb.org/3/tv/popular?"
    let apiKey = "4c7c23354f6e2512d89b178d374949ab"
    
    func fetchTvSeries(completion: @escaping (Bool, TvShowList) -> ()) {
        
        DispatchQueue.global().async {
            print("\(self.baseUrl)api_key=\(self.apiKey)&language=tr-TR&page=1")
            AF.request("\(self.baseUrl)api_key=\(self.apiKey)&language=tr-TR&page=1", method: .get).responseDecodable(of: TvShowList.self) { (response) in
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
