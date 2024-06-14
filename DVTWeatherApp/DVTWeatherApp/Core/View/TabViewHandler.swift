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
    NavigationView {
      TabView {
        HomeTabView(
          homeTabViewModel: HomeTabViewModel()
        )
        .tabItem {
          Label("Home", systemImage: "house.fill")
        }
        .environmentObject(locationManager)

        FavouritesTableView()
          .tabItem {
            Label("Favourites", systemImage: "heart.fill")
          }
      }
    }
  }
}

#Preview {
  TabViewHandler()
}
