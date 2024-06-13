//
//  BackgroundColorEnum.swift
//  DVTWeatherApp
//
//  Created by Bonginkosi Tshabalala on 2024/06/13.
//

import Foundation
import SwiftUI

enum BackgroundColorCode {
  case sunny
  case cloudy
  case rainy

  var color: Color {
    switch self {
    case .sunny:
      return Color(hex: "#47AB2F")
    case .cloudy:
      return Color(hex: "#54717A")
    case .rainy:
      return Color(hex: "#57575D")
    }
  }

  init(imageName: BackgroundImageName) {
    switch imageName {
    case .sunny:
      self = .sunny
    case .cloudy:
      self = .cloudy
    case .rainy:
      self = .rainy
    }
  }
}
