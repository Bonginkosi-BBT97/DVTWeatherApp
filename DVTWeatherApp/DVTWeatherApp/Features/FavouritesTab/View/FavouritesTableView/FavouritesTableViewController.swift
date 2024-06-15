//
//  FavouritesTableViewController.swift
//  DVTWeatherApp
//
//  Created by Bonginkosi Tshabalala on 2024/06/14.
//

import UIKit

class FavouritesTableViewController: UITableViewController, FavouritesSearchDelegate {
  func didSaveCity() {
    favouritesViewModel.fetchCities()
    tableView.reloadData()
  }

  var items = ["Johannesburg 12° CLEAR", "Durban 15° CLOUDY", "Pretoria 20° SUNNY "]
  var favouritesViewModel = FavouritesViewModel()
  var homeTabViewModel = HomeTabViewModel()
  override func viewDidLoad() {
    super.viewDidLoad()

    registerXib()

    navigationItem.rightBarButtonItem = UIBarButtonItem(
      title: "Add",
      style: .plain,
      target: self,
      action: #selector(addButtonTapped)
    )

    Task {
      await favouritesViewModel.fetchCities()
      for city in favouritesViewModel.cities {
        if let cityName = city.name {
          await favouritesViewModel.fetchWeatherData(for: cityName)
        }
      }
      print(favouritesViewModel.weatherData)
      DispatchQueue.main.async {
        self.tableView.reloadData() // Reload table view after data is fetched
      }
    }
  }

  private func registerXib() {
    let nib = UINib(nibName: "FavouriteTableViewCell", bundle: nil)
    tableView.register(nib, forCellReuseIdentifier: "Cell")
    tableView.backgroundColor = .white
  }
}
