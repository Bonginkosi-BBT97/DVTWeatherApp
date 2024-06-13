//
//  HomeTabViewModel.swift
//  DVTWeatherApp
//
//  Created by Bonginkosi Tshabalala on 2024/06/12.
//

import CoreLocation
import Foundation

@MainActor
class HomeTabViewModel: ObservableObject {
  @Published var weather: CurrentWeatherResponse?
  @Published var errorMessage: String?

  private let weatherApiService = WeatherAPIService()

  func fetchWeather(for location: CLLocation?) {
    Task {
      do {
        let (lat, lon) = try coordinates(from: location)
        let weatherData = try await weatherApiService.getCurrentWeatherByCoordinates(
          lat: lat,
          lon: lon
        )
        self.weather = weatherData
      } catch {
        self.errorMessage = error.localizedDescription
      }
    }
  }

  func coordinates(from location: CLLocation?) throws -> (Double, Double) {
    guard let location = location else {
      return (37.3230, -122.0322)
    }
    return (location.coordinate.latitude, location.coordinate.longitude)
  }

  func roundTemperatureString(from temperature: Double) -> String {
    let roundedTemperature = Int(round(temperature))

    return "\(roundedTemperature)"
  }
}
