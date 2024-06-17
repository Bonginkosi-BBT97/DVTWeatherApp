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
  private var weatherForecast: WeatherForecastResponse?

  var container: NSPersistentContainer

  @Published var cities: [CityEntity] = []
  @Published var weatherData: [String: CurrentWeatherResponse] = [:]
  @Published var errorMessage: String?

  @Published var forecastDaysOfWeek: [String] = []
  @Published var forecastTemperatures: [String] = []
  @Published var forecastDescriptions: [String] = []
  @Published var forecastIconNames: [String] = []

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
      fetchCities()
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
      print("Error for \(city): \(error)")
    }
  }

  func fetchWeatherForecast(for city: String) {
    Task {
      do {
        let weatherData = try await weatherApiService.getWeatherForecast(city: city)
        self.weatherForecast = weatherData
        WeatherUtilities.updateWeatherForecast(
          forecastResponse: weatherData,
          forecastDaysOfWeek: &forecastDaysOfWeek,
          forecastTemperatures: &forecastTemperatures,
          forecastDescriptions: &forecastDescriptions,
          forecastIconNames: &forecastIconNames
        )
      } catch {
        self.errorMessage = error.localizedDescription
      }
    }
  }

  func clearAllCities() {
    let request: NSFetchRequest<NSFetchRequestResult> = CityEntity.fetchRequest()
    let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: request)

    do {
      try container.viewContext.execute(batchDeleteRequest)
      fetchCities() // Update the local array after deletion
      fetchCities()
    } catch {
      print("Error clearing cities \(error)")
    }
  }
}
