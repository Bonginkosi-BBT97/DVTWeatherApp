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
  var items: [String] = ["Item 1", "Item 2", "Item 3", "Item 4"]
  var filteredItems: [String] = []

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = UIColor.white.withAlphaComponent(0.9)

    searchBar = UISearchBar()
    searchBar.delegate = self
    searchBar.placeholder = "South African City"
    view.addSubview(searchBar)

    tableView = UITableView()
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    view.addSubview(tableView)

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

    filteredItems = items
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return filteredItems.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    cell.textLabel?.text = filteredItems[indexPath.row]
    return cell
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)

    let detailViewController = FavouritesDetailedViewController()
    navigationController?.pushViewController(detailViewController, animated: true)
  }

  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    if searchText.isEmpty {
      filteredItems = items
    } else {
      filteredItems = items.filter { $0.localizedCaseInsensitiveContains(searchText) }
    }
    tableView.reloadData()
  }

  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    searchBar.resignFirstResponder()
  }
}
