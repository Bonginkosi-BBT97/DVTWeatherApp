//
//  FavouritesSearchViewController+Extension.swift
//  DVTWeatherApp
//
//  Created by Bonginkosi Tshabalala on 2024/06/14.
//

import Foundation
import UIKit

extension FavouritesSearchViewController: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
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

    let cityName = filteredCities[indexPath.row].name
    print("Selected city: \(cityName)")

    favouritesViewModel.saveCity(name: cityName) { success in
      if success {
        print("City saved: \(cityName)")
        DispatchQueue.main.async {
          self.dismiss(animated: true, completion: nil)
        }
      } else {
        print("Failed to save city: \(cityName)")
        // Optionally show an alert or handle the failure
      }
    }
  }

  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    if searchText.isEmpty {
      filteredCities = cities
    } else {
      filteredCities = cities.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }
    print("Filtered cities: \(filteredCities)")
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
