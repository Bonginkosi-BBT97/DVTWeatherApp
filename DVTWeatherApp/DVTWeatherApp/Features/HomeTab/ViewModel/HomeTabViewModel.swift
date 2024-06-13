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
  private var currentWeather: CurrentWeatherResponse?
  private var weatherForecast: WeatherForecastResponse?

  func fetchCurrentWeather(for location: CLLocation?) {
    Task {
      do {
        let (lat, lon) = try coordinates(from: location)
        let weatherData = try await weatherApiService.getCurrentWeatherByCoordinates(
          lat: lat,
          lon: lon
        )
        self.currentWeather = weatherData
        updateCurrentWeatherProperties()
      } catch {
        self.errorMessage = error.localizedDescription
      }
    }
  }

  func fetchWeatherForecast(for location: CLLocation?) {
    Task {
      do {
        let (lat, lon) = try coordinates(from: location)
        let weatherData = try await weatherApiService.getWeatherForecastByCoordinates(
          lat: lat,
          lon: lon
        )
        self.weatherForecast = weatherData

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

  private func updateCurrentWeatherProperties() {
    guard let weather = currentWeather else { return }

    currentTemperature = roundTemperatureString(from: weather.main.temp)
    currentMinTemperature = roundTemperatureString(from: weather.main.tempMin)
    currentMaxTemperature = roundTemperatureString(from: weather.main.tempMax)
    print(weather.name)

    let weatherDescription = WeatherDescription(description: weather.weather.first?.main ?? "SUNNY")
    currentWeatherDescription = weatherDescription.rawValue

    let backgroundImage = BackgroundImageName(description: weatherDescription)
    backgroundImageName = backgroundImage.rawValue

    let backgroundColor = BackgroundColorCode(imageName: backgroundImage)
    self.backgroundColor = backgroundColor.color
  }

  func roundTemperatureString(from temperature: Double) -> String {
    let roundedTemperature = Int(round(temperature))
    return "\(roundedTemperature)"
  }

  func getDayOfWeek(from dateString: String) -> String? {
    return ""
  }
}
