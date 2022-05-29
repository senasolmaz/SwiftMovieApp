//
//  Constants.swift
//  EtsTurMovieDB
//


import Foundation
import UIKit

struct Constants {
    
    static let imagePath = "https://image.tmdb.org/t/p/w300_and_h450_bestv2/"
    static let fetchBaseUrl = "https://api.themoviedb.org/3/tv/popular?"
    static let apiKey = "4c7c23354f6e2512d89b178d374949ab"
    static let searchUrl = "https://api.themoviedb.org/3/search/tv?"
}

extension UIViewController {
    
    func urlConvertImage(url: String) -> UIImage {
        
        let url = URL(string: Constants.imagePath + url)
        let data = try? Data(contentsOf: url!)

        if let imageData = data {
            let image = UIImage(data: imageData)
            return image!
        }
        return UIImage()
    }
}
