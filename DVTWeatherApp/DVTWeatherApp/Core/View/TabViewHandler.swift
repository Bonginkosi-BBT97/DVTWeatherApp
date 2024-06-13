//
//  TabViewHandler.swift
//  DVTWeatherApp
//
//  Created by Bonginkosi Tshabalala on 2024/06/11.
//

import SwiftUI

struct TabViewHandler: View {
  @StateObject private var locationManager = LocationManager()
  var body: some View {
    TabView {
      HomeTabView(
        homeTabViewModel: HomeTabViewModel(),
        currentTemperature: "25",
        currentMinTemperature: "30",
        currentMaxTemperature: "19",
        currentWeatherDescription: "SUNNY",
        backgroundImageName: "sunny",
        backgroundColor: Color.green
      )
      .tabItem {
        Label("Home", systemImage: "house.fill")
      }
      .environmentObject(locationManager)
    }
  }
}

#Preview {
  TabViewHandler()
}
