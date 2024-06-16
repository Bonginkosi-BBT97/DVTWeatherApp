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

  static func getDayWeek(from dateString: String) -> String {
    return ""
  }

  static func updateWeatherForecast() {}
}
