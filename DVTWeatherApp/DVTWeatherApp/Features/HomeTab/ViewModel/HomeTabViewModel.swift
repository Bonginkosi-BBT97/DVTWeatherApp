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
        self.updateWeatherForecast(forecastResponse: weatherData)
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
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    guard let date = formatter.date(from: dateString) else { return nil }
    formatter.dateFormat = "EEEE"
    return formatter.string(from: date)
  }

  private func updateWeatherForecast(forecastResponse: WeatherForecastResponse) {
    var uniqueDays = Set<String>()
    var printedDaysCount = 0

    let forecastDetails = forecastResponse.list.map { forecast -> (
      day: String,
      temperature: String,
      description: String
    ) in
      let day = getDayOfWeek(from: forecast.dtTxt) ?? "Week Day"
      let temperature = String(format: "%.2f", forecast.main.temp)
      let description = forecast.weather.first?.main.description ?? "Description"
      return (day, temperature, description)
    }

    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    let todayDateString = dateFormatter.string(from: Date())
    let today = getDayOfWeek(from: "\(todayDateString) 00:00:00") ?? "Week Day"

    for detail in forecastDetails {
      if printedDaysCount >= 5 {
        break
      }

      if detail.day == today {
        continue
      }

      if !uniqueDays.contains(detail.day) {
        print(
          "Day: \(detail.day), Temperature: \(roundTemperatureString(from: Double(detail.temperature) ?? 0.0)), Description: \(detail.description)"
        )
        uniqueDays.insert(detail.day)
        printedDaysCount += 1
      }
    }
  }
}
