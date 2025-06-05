//
//  CDFavoriteCity+CoreDataProperties.swift
//  Weather
//
//  Created by Oleksandr Borysenko on 17.02.2025.
//
//

import Foundation
import CoreData


extension CDFavoriteCity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDFavoriteCity> {
        return NSFetchRequest<CDFavoriteCity>(entityName: "CDFavoriteCity")
    }

    @NSManaged public var id: Int64
    @NSManaged public var name: String

}

extension CDFavoriteCity : Identifiable {

}
