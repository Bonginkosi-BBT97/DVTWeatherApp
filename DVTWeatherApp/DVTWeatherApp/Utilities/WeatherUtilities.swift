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
    
    static func getDayOfWeek(from dateString: String) -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let date = formatter.date(from: dateString) else { return nil }
        formatter.dateFormat = "EEEE"
        return formatter.string(from: date)
    }
    static func updateWeatherForecast() {}
}
