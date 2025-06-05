//
//  CoreDataService+WeatherInfo.swift
//  Weather
//
//  Created by Oleksandr Borysenko on 11.02.2025.
//

import Foundation
import CoreData

extension CoreDataService {
    func saveWeatherInfo(weatherInfo: WeatherInfo) {
        var cdWeatherInfo: CDWeatherInfo
        if let savedInfo = fetchCDWeatherInfoObjectBy(id: weatherInfo.id) {
            cdWeatherInfo = savedInfo
        } else {
            cdWeatherInfo = CDWeatherInfo(context: context)
            cdWeatherInfo.id = weatherInfo.id
            cdWeatherInfo.name = weatherInfo.name
        }
        
        let cdMain = CDWeatherInfoMain(context: context)
        cdMain.temp = weatherInfo.main.temp
        cdMain.feels_like = weatherInfo.main.feels_like
        cdMain.temp_min = weatherInfo.main.temp_min
        cdMain.temp_max = weatherInfo.main.temp_max
        cdMain.weatherInfo = cdWeatherInfo
        cdWeatherInfo.main = cdMain
        
        let cdSys = Sys(context: context)
        cdSys.country = weatherInfo.sys.country
        cdSys.sunrise = weatherInfo.sys.sunrise
        cdSys.sunset = weatherInfo.sys.sunset
        cdSys.weatherInfo = cdWeatherInfo
        cdWeatherInfo.sys = cdSys
        
        var weatherSet = Set<CDWeatherInfoDetails>()
        for weather in weatherInfo.weather {
            let cdWeatherDetails = CDWeatherInfoDetails(context: context)
            cdWeatherDetails.id = weather.id
            cdWeatherDetails.main = weather.main
            cdWeatherDetails.icon = weather.icon
            cdWeatherDetails.weatherInfo = cdWeatherInfo
            weatherSet.insert(cdWeatherDetails)
        }
        cdWeatherInfo.weather = weatherSet as NSSet
        
        cdWeatherInfo.timeinterval = Date.now
        
        let coordinates = CDCoord(context: context)
        coordinates.lat = convertDouble(weatherInfo.coord.lat)
        coordinates.lon = convertDouble(weatherInfo.coord.lon)
        cdWeatherInfo.coord = coordinates
        
        save(context: context)
        
    }

    func getWeatherInfoBy(name: String) -> WeatherInfo? {
        let fetchRequest: NSFetchRequest<CDWeatherInfo> = CDWeatherInfo.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        
        let result = fetchDataFromEntity(CDWeatherInfo.self,
                            context: context,
                            fetchRequest: fetchRequest,
                            sort: nil,
                            wantFault: false)
        
        if let cdWeather = result.first {
            return WeatherInfo(
                id: cdWeather.id,
                name: cdWeather.name ?? "",
                main: WeatherInfoMain(
                    temp: cdWeather.main?.temp ?? 0.0,
                    feels_like: cdWeather.main?.feels_like ?? 0.0,
                    temp_min: cdWeather.main?.temp_min ?? 0.0,
                    temp_max: cdWeather.main?.temp_max ?? 0.0
                ),
                weather: (cdWeather.weather as? Set<CDWeatherInfoDetails>)?.map { cdDetail in
                    WeatherInfoDetails(
                        id: cdDetail.id,
                        main: cdDetail.main ?? "",
                        icon: cdDetail.icon ?? ""
                    )
                } ?? [],
                sys: SysDetails(
                    country: cdWeather.sys?.country ?? "",
                    sunrise: cdWeather.sys?.sunrise ?? 0,
                    sunset: cdWeather.sys?.sunset ?? 0
                ),
                timeinterval: cdWeather.timeinterval,
                coord: WeatherCoordinates(lat: cdWeather.coord!.lat, lon: cdWeather.coord!.lon)
            )
        }
        return nil
    }
    
    func getWeatherInfoBy(coordinates: Coordinates) -> WeatherInfo? {
        let weatherInfo = fetchCDWeatherInfoObjectBy(coordinates: coordinates)
        
        if let cdWeather = weatherInfo {
            return WeatherInfo(
                id: cdWeather.id,
                name: cdWeather.name ?? "",
                main: WeatherInfoMain(
                    temp: cdWeather.main?.temp ?? 0.0,
                    feels_like: cdWeather.main?.feels_like ?? 0.0,
                    temp_min: cdWeather.main?.temp_min ?? 0.0,
                    temp_max: cdWeather.main?.temp_max ?? 0.0
                ),
                weather: (cdWeather.weather as? Set<CDWeatherInfoDetails>)?.map { cdDetail in
                    WeatherInfoDetails(
                        id: cdDetail.id,
                        main: cdDetail.main ?? "",
                        icon: cdDetail.icon ?? ""
                    )
                } ?? [],
                sys: SysDetails(
                    country: cdWeather.sys?.country ?? "",
                    sunrise: cdWeather.sys?.sunrise ?? 0,
                    sunset: cdWeather.sys?.sunset ?? 0
                ),
                timeinterval: cdWeather.timeinterval,
                coord: WeatherCoordinates(lat: cdWeather.coord!.lat, lon: cdWeather.coord!.lon)
            )
        }
        return nil
    }
}

// MARK: - Private methods
private extension CoreDataService {
    func fetchCDWeatherInfoObjectBy(id: Int64) -> CDWeatherInfo? {
        let fetchRequest: NSFetchRequest<CDWeatherInfo> = CDWeatherInfo.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)
        
        do {
            let result = fetchDataFromEntity(CDWeatherInfo.self,
                                context: context,
                                fetchRequest: fetchRequest,
                                sort: nil,
                                wantFault: false)
            return result.first
        }
    }
    
    func fetchCDWeatherInfoObjectBy(coordinates: Coordinates) -> CDWeatherInfo? {
        let lat = Double(coordinates.lat.replacingOccurrences(of: ",", with: "."))
        let long = Double(coordinates.long.replacingOccurrences(of: ",", with: "."))
        
        let fetchRequest: NSFetchRequest<CDWeatherInfo> = CDWeatherInfo.fetchRequest()
        
        if let latitute = lat, let longitude = long {
            fetchRequest.predicate = NSPredicate(format: "coord.lat == %f AND coord.lon == %f", convertDouble(latitute), convertDouble(longitude))
            
            do {
                let results = try context.fetch(fetchRequest)
                return results.first
            } catch {
                print("Error fetching weather by coordinates: \(error)")
                return nil
            }
        }
        return nil
    }
    
    func convertDouble(_ value: Double) -> Double {
        return round(100 * value) / 100
    }
}
 
