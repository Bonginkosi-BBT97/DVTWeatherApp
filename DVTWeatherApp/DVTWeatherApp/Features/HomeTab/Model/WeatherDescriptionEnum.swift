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
    case "MIST":
      self = .mist
    case "SMOKE":
      self = .smoke
    case "HAZE":
      self = .haze
    case "DUST":
      self = .dust
    case "FOG":
      self = .fog
    case "SAND":
      self = .sand
    case "ASH":
      self = .ash
    case "SQUALL":
      self = .squall
    case "TORNADO":
      self = .tornado
    default:
      self = .unknown
    }
  }
}
