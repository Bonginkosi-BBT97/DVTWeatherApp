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
  case snowy
  case sunny

  init(description: WeatherDescription) {
    switch description {
    case .clouds, .clear:
      self = .cloudy
    case .rain, .snow:
      self = .rainy
    case .unknown:
      self = .sunny
    }
  }
}
