//
//  FavouritesTableView.swift
//
//
//  Created by Bonginkosi Tshabalala on 2024/06/14.
//

import SwiftUI

struct FavouritesTableView: UIViewControllerRepresentable {
  func makeUIViewController(context: Context) -> UINavigationController {
    let favouritesTableViewController = FavouritesTableViewController()
    let navigationController = UINavigationController(rootViewController: favouritesTableViewController)
    return navigationController
  }

  func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {}
}
