//
//  HomeTabViewModel.swift
//  DVTWeatherApp
//
//  Created by Bonginkosi Tshabalala on 2024/06/12.
//

import Combine
import CoreLocation
import Foundation

@MainActor
class HomeTabViewModel: ObservableObject {
  @Published var weather: CurrentWeatherResponse?
  @Published var errorMessage: String?

  private let locationManager: LocationManager
  private let weatherApiService = WeatherAPIService()
  private var cancellables = Set<AnyCancellable>()

  init(locationManager: LocationManager) {
    self.locationManager = locationManager
    setupLocationSubscription()
  }

  private func setupLocationSubscription() {
    // Observe the location for updates
    locationManager.$location
      .compactMap { $0 } // Ignore nil values
      .sink { [weak self] location in
        self?.fetchWeather(for: location)
      }
      .store(in: &cancellables) // Store the subscription
  }

  private func fetchWeather(for location: CLLocation) {
    Task {
      do {
        let weatherData = try await weatherApiService.getCurrentWeatherByCoordinates(
          lat: location.coordinate.latitude,
          lon: location.coordinate.longitude
        )
        self.weather = weatherData
      } catch {
        self.errorMessage = error.localizedDescription
      }
    }
  }
}
