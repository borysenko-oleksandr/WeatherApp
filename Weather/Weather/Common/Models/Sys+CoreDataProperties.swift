//
//  Sys+CoreDataProperties.swift
//  Weather
//
//  Created by Oleksandr Borysenko on 11.02.2025.
//
//

import Foundation
import CoreData


extension Sys {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Sys> {
        return NSFetchRequest<Sys>(entityName: "CDSys")
    }

    @NSManaged public var country: String?
    @NSManaged public var sunrise: Int64
    @NSManaged public var sunset: Int64
    @NSManaged public var weatherInfo: CDWeatherInfo?

}

extension Sys : Identifiable {

}
