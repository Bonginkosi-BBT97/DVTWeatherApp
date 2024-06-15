//
//  FavouritesTableViewController.swift
//  DVTWeatherApp
//
//  Created by Bonginkosi Tshabalala on 2024/06/14.
//

import UIKit

class FavouritesTableViewController: UITableViewController, FavouritesSearchDelegate {
  var favouritesViewModel = FavouritesViewModel()
  var homeTabViewModel = HomeTabViewModel()
  override func viewDidLoad() {
    super.viewDidLoad()

    registerXib()
    tableView.rowHeight = 80
    navigationItem.rightBarButtonItem = UIBarButtonItem(
      title: "Add",
      style: .plain,
      target: self,
      action: #selector(addButtonTapped)
    )
    navigationItem.leftBarButtonItem = UIBarButtonItem(
      title: "Delete All",
      style: .plain,
      target: self,
      action: #selector(deleteButtonTapped)
    )

    Task {
      await favouritesViewModel.fetchCities()
      for city in favouritesViewModel.cities {
        if let cityName = city.name {
          await favouritesViewModel.fetchWeatherData(for: cityName)
        }
      }
      DispatchQueue.main.async {
        self.tableView.reloadData()
      }
    }
  }

  private func registerXib() {
    let nib = UINib(nibName: "FavouriteTableViewCell", bundle: nil)
    tableView.register(nib, forCellReuseIdentifier: "Cell")
    tableView.backgroundColor = .white
  }
}
