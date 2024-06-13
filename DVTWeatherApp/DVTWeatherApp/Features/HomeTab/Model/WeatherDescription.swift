//
//  WeatherDescription.swift
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
    default:
      self = .unknown
    }
  }
}
