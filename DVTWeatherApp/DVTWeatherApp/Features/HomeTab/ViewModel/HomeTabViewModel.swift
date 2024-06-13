//
//  HomeTabViewModel.swift
//  DVTWeatherApp
//
//  Created by Bonginkosi Tshabalala on 2024/06/12.
//

import CoreLocation
import Foundation
import SwiftUI

@MainActor
class HomeTabViewModel: ObservableObject {
  @Published var currentTemperature: String = ""
  @Published var currentMinTemperature: String = ""
  @Published var currentMaxTemperature: String = ""
  @Published var currentWeatherDescription: String = ""
  @Published var backgroundImageName: String = ""
  @Published var backgroundColor: Color = .white
  @Published var errorMessage: String?

  private let weatherApiService = WeatherAPIService()
  private var weather: CurrentWeatherResponse?

  func fetchWeather(for location: CLLocation?) {
    Task {
      do {
        let (lat, lon) = try coordinates(from: location)
        let weatherData = try await weatherApiService.getCurrentWeatherByCoordinates(
          lat: lat,
          lon: lon
        )
        self.weather = weatherData
        updateWeatherProperties()
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

  private func updateWeatherProperties() {
    guard let weather = weather else { return }

    currentTemperature = roundTemperatureString(from: weather.main.temp)
    currentMinTemperature = roundTemperatureString(from: weather.main.tempMin)
    currentMaxTemperature = roundTemperatureString(from: weather.main.tempMax)

    let weatherDescription = WeatherDescription(description: weather.weather.first?.main ?? "SUNNY")
    currentWeatherDescription = weatherDescription.rawValue
    print(currentWeatherDescription)
    let backgroundImage = BackgroundImageName(description: weatherDescription)
    backgroundImageName = backgroundImage.rawValue

    let backgroundColor = BackgroundColorCode(imageName: backgroundImage)
    self.backgroundColor = backgroundColor.color
  }

  func roundTemperatureString(from temperature: Double) -> String {
    let roundedTemperature = Int(round(temperature))
    return "\(roundedTemperature)"
  }
}
