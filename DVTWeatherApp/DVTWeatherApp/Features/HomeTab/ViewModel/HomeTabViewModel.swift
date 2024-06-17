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

  @Published var forecastDaysOfWeek: [String] = []
  @Published var forecastTemperatures: [String] = []
  @Published var forecastDescriptions: [String] = []
  @Published var forecastIconNames: [String] = []

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

  func coordinates(from location: CLLocation?) throws -> (Double, Double) {
    guard let location = location else {
      return (37.3230, -122.0322)
    }
    return (location.coordinate.latitude, location.coordinate.longitude)
  }

  private func updateCurrentWeatherProperties() {
    guard let weather = currentWeather else { return }

    currentTemperature = WeatherUtilities.roundTemperatureString(from: weather.main.temp)
    currentMinTemperature = WeatherUtilities.roundTemperatureString(from: weather.main.tempMin)
    currentMaxTemperature = WeatherUtilities.roundTemperatureString(from: weather.main.tempMax)

    let weatherDescription = WeatherDescription(description: weather.weather.first?.main ?? "SUNNY")
    currentWeatherDescription = weatherDescription.rawValue

    let backgroundImage = BackgroundImageName(description: weatherDescription)
    backgroundImageName = backgroundImage.rawValue

    let backgroundColor = BackgroundColorCode(imageName: backgroundImage)
    self.backgroundColor = backgroundColor.color
  }
}
