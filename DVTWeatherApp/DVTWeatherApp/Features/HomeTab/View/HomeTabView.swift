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
  let backgroundImageName: String
  let backgroundColor: Color

  var body: some View {
    VStack {
      topSection
      CustomDividerView()
      middleSection
      bottomSection
      Spacer()
    }
    .background(backgroundColor)
  }
}

#Preview {
  HomeTabView(
    currentTemperature: "25",
    weatherTitle: "SUNNY",
    backgroundImageName: "sunny",
    backgroundColor: Color.green
  )
}
