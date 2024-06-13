//
//  ForecastIconNameEnum.swift
//  DVTWeatherApp
//
//  Created by Bonginkosi Tshabalala on 2024/06/14.
//

import Foundation

enum ForecastIconNameEnum: String {
  case partlysunny
  case rain
  case clear

  init(description: WeatherDescription) {
    switch description {
    case .clouds, .clear, .ash, .dust, .smoke, .sand, .tornado, .haze:
      self = .partlysunny
    case .rain, .snow, .drizzle, .thunderstorm, .fog, .mist, .squall:
      self = .rain
    case .unknown:
      self = .clear
    }
  }
}
