//
//  DVTWeatherApp.swift
//  DVTWeatherApp
//
//  Created by Bonginkosi Tshabalala on 2024/06/11.
//

import SwiftUI

@main
struct DVTWeatherApp: App {
  @StateObject var locationManager = LocationManager()
  var body: some Scene {
    WindowGroup {
      ContentView()
        .environmentObject(locationManager)
    }
  }
}
