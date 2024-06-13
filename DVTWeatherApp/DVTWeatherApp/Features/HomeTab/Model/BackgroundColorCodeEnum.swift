//
//  BackgroundColorCode.swift
//  DVTWeatherApp
//
//  Created by Bonginkosi Tshabalala on 2024/06/13.
//

import Foundation
enum BackgroundColorCode {
    case sunny
    case cloudy
    case rainy
    case snowy

    var colorCode: String {
        switch self {
        case .sunny:
            return "#47AB2F"
        case .cloudy:
            return "#54717A"
        case .rainy, .snowy:
            return "#57575D"
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
        case .snowy:
            self = .snowy
        }
    }
}
