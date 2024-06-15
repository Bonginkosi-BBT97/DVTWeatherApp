//
//  FavouritesViewModel.swift
//
//
//  Created by Bonginkosi Tshabalala on 2024/06/15.
//

import CoreData
import Foundation

class FavouritesViewModel: ObservableObject {
  private let weatherApiService = WeatherAPIService()
  var container: NSPersistentContainer

  @Published var cities: [CityEntity] = []
  @Published var weatherData: [String: CurrentWeatherResponse] = [:]
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

  func saveCity(name: String, completion: @escaping (Bool) -> Void) {
    guard !cityExists(name: name) else {
      completion(false)
      return
    }
    let newCity = CityEntity(context: container.viewContext)
    newCity.name = name
    do {
      try container.viewContext.save()
      fetchCities() // Call fetchCities synchronously
      completion(true)
    } catch {
      print("Error saving city \(name): \(error)")
      completion(false)
    }
  }

  func fetchWeatherData(for city: String) async {
    do {
      let weather = try await weatherApiService.getCurrentWeather(city: city)
      DispatchQueue.main.async {
        self.weatherData[city] = weather
      }
    } catch {
      print("Error fetching weather data for \(city): \(error)")
    }
  }
}
