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
  @State private var cancellable: AnyCancellable?

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
      cancellable = locationManager.$location
        .debounce(for: .seconds(2), scheduler: RunLoop.main)
        .sink { _ in
          self.updateWeatherIfLocationAvailable()
        }
    }
    .onDisappear {
      cancellable?.cancel()
    }
  }

  private func updateWeatherIfLocationAvailable() {
    guard let location = locationManager.location else {
      return
    }
    homeTabViewModel.fetchCurrentWeather(for: location)
    homeTabViewModel.fetchWeatherForecast(for: location)
  }
}
