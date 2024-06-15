//
//  FavouritesViewModel.swift
//
//
//  Created by Bonginkosi Tshabalala on 2024/06/15.
//

import CoreData
import Foundation

class FavouritesViewModel: ObservableObject {
  var container: NSPersistentContainer

  @Published var cities: [CityEntity] = []
  init() {
    self.container = NSPersistentContainer(name: "FavouritesContainer")
    container.loadPersistentStores { _, error in
      if let error = error {
        print("ERROR LOADING CORE DATA. \(error)")
      }
    }
  }

  func fetchCities() {
    let request: NSFetchRequest<CityEntity> = CityEntity.fetchRequest()
    do {
      cities = try container.viewContext.fetch(request)
    } catch {
      print("Error fetching cities: \(error)")
    }
  }

  func cityExists(name: String) -> Bool {
    let request: NSFetchRequest<CityEntity> = CityEntity.fetchRequest()
    request.predicate = NSPredicate(format: "name == %@", name)
    do {
      let count = try container.viewContext.count(for: request)
      return count > 0
    } catch {
      print("Error checking if city exists: \(error)")
      return false
    }
  }

  func saveCity(name: String) {}
}
