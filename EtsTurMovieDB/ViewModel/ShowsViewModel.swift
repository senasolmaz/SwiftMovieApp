//
//  ShowsViewModel.swift
//  EtsTurMovieDB


import Foundation

class ShowsViewModel: BaseViewModel {
    
    public var tvShowsModel: [TvShowItem]! {
           didSet {
               self.reloadTableView?()
           }
       }
       
       func getTvSeriesData(){
           showLoading?()
           serviceValue.fetchTvSeries() { (success, data) in
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
