//
//  CDCoord+CoreDataProperties.swift
//  Weather
//
//  Created by Oleksandr Borysenko on 17.02.2025.
//
//

import Foundation
import CoreData


extension CDCoord {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDCoord> {
        return NSFetchRequest<CDCoord>(entityName: "CDCoord")
    }

    @NSManaged public var lon: Double
    @NSManaged public var lat: Double

}

extension CDCoord : Identifiable {

}
