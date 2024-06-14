//
//  HomeTabView.swift
//  DVTWeatherApp
//
//  Created by Bonginkosi Tshabalala on 2024/06/12.
//

import Combine
import CoreLocation
import SwiftUI

struct HomeTabView: View {
  @EnvironmentObject var locationManager: LocationManager
  @StateObject var homeTabViewModel = HomeTabViewModel()

  var body: some View {
    VStack {
      topSection
      CustomDividerView()
      middleSection
      bottomSection
      Spacer()
    }
    .background(homeTabViewModel.backgroundColor)
    .onAppear {
      updateWeatherIfLocationAvailable()
    }
    .onChange(of: locationManager.location) { _ in
      updateWeatherIfLocationAvailable()
    }
  }

  private func updateWeatherIfLocationAvailable() {
    if let location = locationManager.location {
      homeTabViewModel.fetchCurrentWeather(for: location)
      homeTabViewModel.fetchWeatherForecast(for: location)
    }
  }
}
