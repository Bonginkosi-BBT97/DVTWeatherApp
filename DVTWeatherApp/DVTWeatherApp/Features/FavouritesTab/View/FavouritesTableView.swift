//
//  FavouritesTableView+Representable.swift
//
//
//  Created by Bonginkosi Tshabalala on 2024/06/14.
//

import SwiftUI
import UIKit

struct FavouritesTableView: UIViewControllerRepresentable {
  func makeUIViewController(context: Context) -> FavouritesTableViewController {
    return FavouritesTableViewController()
  }

  func updateUIViewController(_ uiViewController: FavouritesTableViewController, context: Context) {

  }
}
