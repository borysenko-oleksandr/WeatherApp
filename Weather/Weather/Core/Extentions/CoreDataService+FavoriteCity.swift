//
//  CoreDataService+FavoriteCity.swift
//  Weather
//
//  Created by Oleksandr Borysenko on 17.02.2025.
//

import CoreData

extension CoreDataService {
    func saveFavoriteCity(city: FavoriteCity) {
        let cdFavoriteCity = CDFavoriteCity(context: context)
        
        cdFavoriteCity.id = city.id
        cdFavoriteCity.name = city.name

        save(context: context)
    }
    
    func removeFavoriteBy(id: Int64) {
        let fetchRequest: NSFetchRequest<CDFavoriteCity> = CDFavoriteCity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)
        deleteRecords(CDFavoriteCity.self, fetchRequest: fetchRequest)
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
