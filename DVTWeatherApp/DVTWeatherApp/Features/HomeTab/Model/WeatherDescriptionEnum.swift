//
//  WeatherDescriptionEnum.swift
//  DVTWeatherApp
//
//  Created by Bonginkosi Tshabalala on 2024/06/13.
//

import Foundation

enum WeatherDescription: String {
  case rain = "RAINY"
  case snow = "SNOWY"
  case clouds = "CLOUDY"
  case clear = "CLEAR"
  case atmosphere = "ATOMSPHERE"
  case drizzle = "DRIZZLE"
  case thunderstorm = "THUNDERSTORM"
  case unknown = "SUNNY"

  init(description: String) {
    let uppercasedDescription = description.uppercased()

    switch uppercasedDescription {
    case "RAIN":
      self = .rain
    case "SNOW":
      self = .snow
    case "CLOUDS":
      self = .clouds
    case "CLEAR":
      self = .clear
    case "ATOMSPHERE":
      self = .atmosphere
    case "DRIZZLE":
      self = .drizzle
    case "THUNDERSTORM":
      self = .thunderstorm
    default:
      self = .unknown
    }
  }
}
