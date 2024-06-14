//
//  FavouritesSearchViewController.swift
//  DVTWeatherApp
//
//  Created by Bonginkosi Tshabalala on 2024/06/14.
//

import UIKit

class FavouritesSearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,
UISearchBarDelegate {
  var tableView: UITableView!
  var searchBar: UISearchBar!
  let cities = LocalCities().localCities
  var filteredCities: [LocalCityName] = []

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

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return filteredCities.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    cell.textLabel?.text = filteredCities[indexPath.row].name
    return cell
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)

    print(filteredCities[indexPath.row].name)
  }

  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    if searchText.isEmpty {
      filteredCities = cities
    } else {
      filteredCities = cities.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }
    tableView.reloadData()
  }

  func loadConstraints() {
    searchBar.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
    ])

    tableView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
    ])
  }
}
