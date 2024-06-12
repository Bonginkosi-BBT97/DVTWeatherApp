//
//  HomeTabView.swift
//  DVTWeatherApp
//
//  Created by Bonginkosi Tshabalala on 2024/06/12.
//

import SwiftUI

struct HomeTabView: View {
  let currentTemperature: String
  let weatherTitle: String

  var body: some View {
    VStack {
      topSection
      Spacer()
      middleSection
      bottomSection
      Spacer()
    }
  }
}

#Preview {
  HomeTabView(currentTemperature: "25", weatherTitle: "SUNNY")
}
