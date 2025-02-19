//
//  CDWeatherInfoDetails+CoreDataProperties.swift
//  Weather
//
//  Created by Oleksandr Borysenko on 17.02.2025.
//
//

import Foundation
import CoreData


extension CDWeatherInfoDetails {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDWeatherInfoDetails> {
        return NSFetchRequest<CDWeatherInfoDetails>(entityName: "CDWeatherInfoDetails")
    }

    @NSManaged public var icon: String?
    @NSManaged public var id: Int64
    @NSManaged public var main: String?
    @NSManaged public var weatherInfo: CDWeatherInfo?

}

extension CDWeatherInfoDetails : Identifiable {

}
