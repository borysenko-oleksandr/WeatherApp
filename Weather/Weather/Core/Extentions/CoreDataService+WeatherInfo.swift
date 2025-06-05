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
        let cdWeatherInfo = CDWeatherInfo(context: context)
        
        cdWeatherInfo.id = weatherInfo.id
        cdWeatherInfo.name = weatherInfo.name
        
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
        
        CoreDataService.shared.save(context: context)
        
    }
    
    func saveFavoriteCity(city: FavoriteCity) {
        let cdFavoriteCity = CDFavoriteCity(context: context)
        
        cdFavoriteCity.id = city.id
        cdFavoriteCity.name = city.name

        CoreDataService.shared.save(context: context)
    }

    func removeFavoriteBy(id: Int64) {
        let fetchRequest: NSFetchRequest<CDFavoriteCity> = CDFavoriteCity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)
        CoreDataService.shared.deleteRecords(CDFavoriteCity.self, fetchRequest: fetchRequest)
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
                timeinterval: cdWeather.timeinterval
            )
        }
        return nil
    }
    
    
    func fetchFavoriteCity() -> [FavoriteCity] {
        let fetchRequest = CDFavoriteCity.fetchRequest()
        
        do {
            let results = try context.fetch(fetchRequest)
            
            return results.map { item in
                FavoriteCity(id: item.id, name: item.name)
            }
        } catch {
            return []
        }
    }
    
    func fetchFavoriteCityBy(id: Int64) -> FavoriteCity? {
        let fetchRequest: NSFetchRequest<CDFavoriteCity> = CDFavoriteCity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)
        let cdResult = fetchDataFromEntity(CDFavoriteCity.self,
                            context: context,
                            fetchRequest: fetchRequest,
                            sort: nil,
                            wantFault: false)
        
        if let result = cdResult.first {
            return FavoriteCity(id: result.id, name: result.name)
        } else {
            return nil
        }
    }
}
