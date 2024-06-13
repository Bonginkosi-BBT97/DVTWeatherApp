//
//  DVTWeatherApp.swift
//  DVTWeatherApp
//
//  Created by Bonginkosi Tshabalala on 2024/06/11.
//

import SwiftUI

@main
struct DVTWeatherApp: App {
  init() {
    UITabBar.appearance().backgroundColor = UIColor.systemBackground
    UITabBar.appearance().barTintColor = UIColor.white
    UITabBar.appearance().unselectedItemTintColor = UIColor.gray
    UITabBar.appearance().tintColor = UIColor.white
  }

  @StateObject var locationManager = LocationManager()
  var body: some Scene {
    WindowGroup {
      TabViewHandler()
        .environmentObject(locationManager)
    }
  }
}
