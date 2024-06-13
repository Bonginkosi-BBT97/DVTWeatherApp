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
  case drizzle = "DRIZZLE"
  case thunderstorm = "THUNDERSTORM"
  case unknown = "SUNNY"
  case mist = "MIST"
  case smoke = "SMOKE"
  case haze = "HAZE"
  case dust = "DUST"
  case fog = "FOG"
  case sand = "SAND"
  case ash = "ASH"
  case squall = "SQUALL"
  case tornado = "TORNADO"

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
    case "DRIZZLE":
      self = .drizzle
    case "THUNDERSTORM":
      self = .thunderstorm
    case "MIST", "SMOKE", "HAZE", "DUST", "FOG", "SAND", "ASH", "SQUALL", "TORNADO":
      self = WeatherDescription.atmosphere(from: uppercasedDescription)
    default:
      self = .unknown
    }
  }

  private static func atmosphere(from description: String) -> WeatherDescription {
    switch description {
    case "MIST":
      return .mist
    case "SMOKE":
      return .smoke
    case "HAZE":
      return .haze
    case "DUST":
      return .dust
    case "FOG":
      return .fog
    case "SAND":
      return .sand
    case "ASH":
      return .ash
    case "SQUALL":
      return .squall
    case "TORNADO":
      return .tornado
    default:
      return .unknown
    }
  }
}
