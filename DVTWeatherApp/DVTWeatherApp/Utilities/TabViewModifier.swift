//
//  TabViewModifier.swift
//  DVTWeatherApp
//
//  Created by Bonginkosi Tshabalala on 2024/06/14.
//

import Foundation
import SwiftUI

struct TabViewModifier: ViewModifier {
  init() {
    let tabBarAppearance = UITabBarAppearance()
    tabBarAppearance.backgroundColor = UIColor.white
    tabBarAppearance.stackedLayoutAppearance.normal
      .titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]

    UITabBar.appearance().standardAppearance = tabBarAppearance
    UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
  }

  func body(content: Content) -> some View {
    content
  }
}

extension View {
  func tabBarStyle() -> some View {
    modifier(TabViewModifier())
  }
}
