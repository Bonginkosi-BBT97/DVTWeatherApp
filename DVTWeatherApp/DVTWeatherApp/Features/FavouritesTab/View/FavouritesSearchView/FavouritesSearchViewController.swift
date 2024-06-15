//
//  FavouritesSearchViewController.swift
//  DVTWeatherApp
//
//  Created by Bonginkosi Tshabalala on 2024/06/14.
//

import UIKit
protocol FavouritesSearchDelegate: AnyObject {
  func didSaveCity()
}
class FavouritesSearchViewController: UIViewController {
  var tableView: UITableView!
  var searchBar: UISearchBar!
  let cities = LocalCities().localCities
  var filteredCities: [LocalCityName] = []
  var favouritesViewModel = FavouritesViewModel()

  weak var delegate: FavouritesSearchDelegate?

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = UIColor.white.withAlphaComponent(0.9)

    searchBar = UISearchBar()
    searchBar.delegate = self
    searchBar.placeholder = "South Africa City"
    view.addSubview(searchBar)

    tableView = UITableView()
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    view.addSubview(tableView)

    loadConstraints()

    filteredCities = cities
  }
}
