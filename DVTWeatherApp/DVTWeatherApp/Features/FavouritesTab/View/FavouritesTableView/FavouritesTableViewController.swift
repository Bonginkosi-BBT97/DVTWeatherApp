//
//  FavouritesTableViewController.swift
//  DVTWeatherApp
//
//  Created by Bonginkosi Tshabalala on 2024/06/14.
//

import UIKit

class FavouritesTableViewController: UITableViewController {
  var items = ["Johannesburg 12° CLEAR", "Durban 15° CLOUDY", "Pretoria 20° SUNNY "]
  var favouritesViewModel = FavouritesViewModel()

  override func viewDidLoad() {
    super.viewDidLoad()

    registerXib()

    navigationItem.rightBarButtonItem = UIBarButtonItem(
      title: "Add",
      style: .plain,
      target: self,
      action: #selector(addButtonTapped)
    )
  }

  private func registerXib() {
    let nib = UINib(nibName: "FavouriteTableViewCell", bundle: nil)
    tableView.register(nib, forCellReuseIdentifier: "Cell")
    tableView.backgroundColor = .white
  }
}
