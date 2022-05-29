//
//  Shows+CoreDataProperties.swift
//  
//
//

import Foundation
import CoreData


extension Shows {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Shows> {
        return NSFetchRequest<Shows>(entityName: "Shows")
    }

    @NSManaged public var name: String?
    @NSManaged public var id: Int32
    @NSManaged public var poster_path: String?
    @NSManaged public var backdrop_path: String?
    @NSManaged public var overview: String?
    @NSManaged public var first_air_date: String?
    @NSManaged public var vote_average: Double
    @NSManaged public var original_language: String?

}
