//
//  CDWeatherInfo+CoreDataProperties.swift
//  Weather
//
//  Created by Oleksandr Borysenko on 17.02.2025.
//
//

import Foundation
import CoreData


extension CDWeatherInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDWeatherInfo> {
        return NSFetchRequest<CDWeatherInfo>(entityName: "CDWeatherInfo")
    }

    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var timeinterval: Date?
    @NSManaged public var main: CDWeatherInfoMain?
    @NSManaged public var sys: Sys?
    @NSManaged public var weather: NSSet?
    @NSManaged public var coord: CDCoord?

}

// MARK: Generated accessors for weather
extension CDWeatherInfo {

    @objc(addWeatherObject:)
    @NSManaged public func addToWeather(_ value: CDWeatherInfoDetails)

    @objc(removeWeatherObject:)
    @NSManaged public func removeFromWeather(_ value: CDWeatherInfoDetails)

    @objc(addWeather:)
    @NSManaged public func addToWeather(_ values: NSSet)

    @objc(removeWeather:)
    @NSManaged public func removeFromWeather(_ values: NSSet)

}

extension CDWeatherInfo : Identifiable {

}
