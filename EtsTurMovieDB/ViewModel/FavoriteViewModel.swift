//
//  FavoriteViewModel.swift
//  EtsTurMovieDB
//

import Foundation

class FavoriteViewModel {
    
    var listArray = [Shows]()
    let coreDataHelper = CoreDataHelper()
    
    func fetchData() {
        listArray = coreDataHelper.fetchData() ?? [Shows]()
    }
    
    func saveData(model: TvShowItem) -> Bool {
        if !coreDataHelper.saveData(model: model) {
            return false
        }else {
            return true
        }
    }
    
    func deleteData(index: Int) {
        coreDataHelper.deleteData(index: index)
    }
    
}
