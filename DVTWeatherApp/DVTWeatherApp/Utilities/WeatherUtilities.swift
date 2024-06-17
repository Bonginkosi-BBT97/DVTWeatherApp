//
//  WeatherUtilities.swift
//  DVTWeatherApp
//
//  Created by Bonginkosi Tshabalala on 2024/06/17.
//

import Foundation

enum WeatherUtilities {
  static func roundTemperatureString(from temperature: Double) -> String {
    let roundedTemperature = Int(round(temperature))
    return "\(roundedTemperature)"
  }

  static func getDayOfWeek(from dateString: String) -> String? {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    guard let date = formatter.date(from: dateString) else { return nil }
    formatter.dateFormat = "EEEE"
    return formatter.string(from: date)
  }

  static func updateWeatherForecast(
    forecastResponse: WeatherForecastResponse,
    forecastDaysOfWeek: inout [String],
    forecastTemperatures: inout [String],
    forecastDescriptions: inout [String],
    forecastIconNames: inout [String]
  ) {
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
        forecastDaysOfWeek.append(detail.day)
        forecastTemperatures.append(roundTemperatureString(from: Double(detail.temperature) ?? 0.0))
        forecastDescriptions.append(detail.description)

        if let weatherDescription = WeatherDescription(rawValue: detail.description.uppercased()) {
          let iconName = ForecastIconNameEnum(description: weatherDescription).rawValue
          forecastIconNames.append(iconName)
        } else {
          forecastIconNames.append(ForecastIconNameEnum(description: .unknown).rawValue)
        }

        uniqueDays.insert(detail.day)
        printedDaysCount += 1
      }
    }
  }
}
