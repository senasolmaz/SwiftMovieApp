//
//  SearchViewModel.swift
//  EtsTurMovieDB


import Foundation


class SearchViewModel: BaseViewModel {
    
    public var tvShowsModel: [TvShowItem]! {
           didSet {
               self.reloadTableView?()
           }
       }
       
    func getTvSeriesData(query: String){
           showLoading?()
           serviceValue.searchTvSeries(query: query) { (success, data) in
               if success {
                   self.tvShowsModel = data.results
                   self.hideLoading?()
               }else {
                   self.showError?()
                   self.hideLoading?()
               }
           }
       }
    
}
