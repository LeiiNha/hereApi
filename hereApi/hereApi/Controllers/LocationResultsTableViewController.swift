//
//  LocationResultsTableViewController.swift
//  hereApi
//
//  Created by Erica Geraldes on 15/06/2019.
//  Copyright © 2019 Erica Geraldes. All rights reserved.
//

import UIKit
import MapKit
import NMAKit

final class LocationResultsTableViewController: UITableViewController {

    public var locationManager: CLLocationManager?
    private(set) var locationResults: [NMALink]?
    private(set) var searchBar: SearchBar?
    private(set) var lastResultPage: NMADiscoveryPage?
    let viewModel: LocationResultViewModel
    private enum Constants {
        static let cellHeight: CGFloat = 100.0
    }

    init(style: UITableView.Style, viewModel: LocationResultViewModel) {
        self.viewModel = viewModel
        super.init(style: style)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchBar()
        self.tableView.register(LocationTableViewCell.self,
                                forCellReuseIdentifier: LocationTableViewCell.reuseIdentifier)
    }
}
extension LocationResultsTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.viewModel.searchBar(searchBar, textDidChange: searchBar.text.orDefault(""), {
            self.tableView.reloadData()
        })
    }
}
extension LocationResultsTableViewController {

    func configureSearchBar() {
        searchBar = SearchBar(delegate: self)
        guard let searchBar = self.searchBar else { return }
        searchBar.becomeFirstResponder()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.tableHeaderView = searchBar
        searchBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,
                                       constant: Spacing.large).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
}
    // MARK: - Table view data source
extension LocationResultsTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.numberOfSections(in: tableView)
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.viewModel.tableView(tableView, heightForRowAt: indexPath)
    }
}
    // MARK: - Table view delegate
extension LocationResultsTableViewController {

    override func tableView(_ tableView: UITableView,
                            willDisplay cell: UITableViewCell,
                            forRowAt indexPath: IndexPath) {
        self.viewModel.tableView(tableView, willDisplay: cell, forRowAt: indexPath, {
            self.tableView.reloadData()
        })
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.tableView(tableView, numberOfRowsInSection: section)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.viewModel.tableView(tableView, cellForRowAt: indexPath)
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel.tableView(tableView, didSelectRowAt: indexPath, viewController: self)
    }
}
