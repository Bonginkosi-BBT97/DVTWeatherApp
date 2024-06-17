//
//  FavouritesSearchView.swift
//  DVTWeatherApp
//
//  Created by Bonginkosi Tshabalala on 2024/06/14.
//

import SwiftUI

struct FavouritesSearchView: UIViewControllerRepresentable {
  func makeUIViewController(context: Context) -> UINavigationController {
    let searchViewController = FavouritesSearchViewController()
    let navigationController = UINavigationController(rootViewController: searchViewController)
    return navigationController
  }

  func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {}
}
