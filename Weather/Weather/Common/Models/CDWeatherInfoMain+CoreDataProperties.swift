//
//  CDWeatherInfoMain+CoreDataProperties.swift
//  Weather
//
//  Created by Oleksandr Borysenko on 11.02.2025.
//
//

import Foundation
import CoreData


extension CDWeatherInfoMain {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDWeatherInfoMain> {
        return NSFetchRequest<CDWeatherInfoMain>(entityName: "CDWeatherInfoMain")
    }

    @NSManaged public var temp: Double
    @NSManaged public var feels_like: Double
    @NSManaged public var temp_min: Double
    @NSManaged public var temp_max: Double
    @NSManaged public var weatherInfo: CDWeatherInfo?

}

extension CDWeatherInfoMain : Identifiable {

}
