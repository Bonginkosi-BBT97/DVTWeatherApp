//
//  BackgroundImageNameEnum.swift
//  DVTWeatherApp
//
//  Created by Bonginkosi Tshabalala on 2024/06/13.
//

import Foundation

enum BackgroundImageName: String {
  case cloudy
  case rainy
  case sunny

  init(description: WeatherDescription) {
    switch description {
    case .clouds, .clear, .ash, .dust, .smoke, .sand, .tornado, .haze:
      self = .cloudy

    case .rain, .snow, .drizzle, .thunderstorm, .fog, .mist, .squall:
      self = .rainy
    case .unknown:
      self = .sunny
    }
  }
}
