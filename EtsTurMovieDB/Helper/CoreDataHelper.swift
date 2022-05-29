//
//  CoreDataHelper.swift
//  EtsTurMovieDB
//

import CoreData
import UIKit

class CoreDataHelper {
    
    static let shared = CoreDataHelper()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func fetchData() -> [Shows]? {
        
        do {
            return try self.context.fetch(Shows.fetchRequest())
        }catch  {
            print("error: \(error.localizedDescription)")
        }
        
        return nil
    }
    
    func saveData(model: TvShowItem) -> Bool {
        
        let dataArray = fetchData()
        
        if dataArray!.contains(where: { $0.id == model.id }) != true {
            
            let list = Shows(context: context)
            
            list.backdrop_path = model.backdrop_path
            list.poster_path = model.poster_path
            list.name = model.name
            list.overview = model.overview
            list.id = model.id!
            list.original_language = model.original_language
            list.first_air_date = model.first_air_date
            list.vote_average = model.vote_average!
            
            do {
                try self.context.save()
            }catch {
                print("error: \(error.localizedDescription)")
            }
            return true
        }else {
            return false
        }
    }
    
    func deleteData(index: Int) {
        if let dataArray = fetchData() {
            context.delete(dataArray[index])
            do {
               try self.context.save()
            }catch {
                print("error: \(error.localizedDescription)")
            }
        }
    }
}
