//
//  TabViewHandler.swift
//  DVTWeatherApp
//
//  Created by Bonginkosi Tshabalala on 2024/06/11.
//

import SwiftUI

struct TabViewHandler: View {
  var body: some View {
    TabView {
      HomeTabView(
        currentTemperature: "25",
        currentWeatherDescription: "SUNNY",
        backgroundImageName: "sunny",
        backgroundColor: Color.green
      )
      .tabItem {
        Label("Home", systemImage: "house.fill")
      }
    }
  }
}

#Preview {
  TabViewHandler()
}
