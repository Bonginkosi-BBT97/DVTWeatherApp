//
//  FavouritesTableViewController.swift
//  DVTWeatherApp
//
//  Created by Bonginkosi Tshabalala on 2024/06/14.
//

import UIKit

class FavouritesTableViewController: UITableViewController {
  var items = ["Item 1", "Item 2", "Item 3"]

  override func viewDidLoad() {
    super.viewDidLoad()

    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

    navigationItem.rightBarButtonItem = UIBarButtonItem(
      title: "Add",
      style: .plain,
      target: self,
      action: #selector(addButtonTapped)
    )
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    cell.textLabel?.text = items[indexPath.row]
    return cell
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)

    let detailViewController = FavouritesDetailedViewController()
    navigationController?.pushViewController(detailViewController, animated: true)
  }

  @objc func addButtonTapped() {
    let searchViewController = FavouritesSearchViewController()
    searchViewController.modalPresentationStyle = .overCurrentContext
    searchViewController.modalTransitionStyle = .coverVertical
    present(searchViewController, animated: true, completion: nil)
  }
}
