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

  func fetchWeather(for location: CLLocation) {
    Task {
      do {
        let weatherData = try await weatherApiService.getCurrentWeatherByCoordinates(
          lat: location.coordinate.latitude,
          lon: location.coordinate.longitude
        )
        self.weather = weatherData
      } catch {
        self.errorMessage = error.localizedDescription
      }
    }
  }

  func roundTemperatureString(from temperature: Double) -> String {
    let roundedTemperature = Int(round(temperature))

    return "\(roundedTemperature)"
  }
}
