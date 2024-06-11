//
//  DVTWeatherAppTests.swift
//  DVTWeatherAppTests
//
//  Created by Bonginkosi Tshabalala on 2024/06/11.
//

@testable import DVTWeatherApp
import XCTest

final class DVTWeatherAppTests: XCTestCase {
  let currentWeatherURL =
    "https://api.openweathermap.org/data/2.5/weather?q=London&appid=f77ddc0a24c1b09b6e4f6bd66e3bc0ab&units=metric"
  let cityName = "London"

  func testGetCurrentWeather_Success() async throws {
    // GIVEN
    // WHEN
    // THEN
  }

  func testGetCurrentWeather_Error() async throws {
    // GIVEN
    // WHEN
    // THEN
  }

  func testGetCurrentWeather_InvalidData() async throws {
    // GIVEN
    // WHEN
    // THEN
  }
}
