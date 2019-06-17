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

class LocationResultsTableViewController: UITableViewController {

    public var locationManager: CLLocationManager?
    var locationResults: [NMALink]?
    var searchBar: SearchBar?
    
    enum Constants {
        static let cellHeight: CGFloat = 100.0
    }
    
    override init(style: UITableView.Style) {
        super.init(style: style)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchBar()
        self.tableView.register(LocationTableViewCell.self, forCellReuseIdentifier: "cell")
    }
}
extension LocationResultsTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let locationManager = self.locationManager, let location = locationManager.location else { return }
        let places = NMAPlaces.shared().makeSearchRequest(location: NMAGeoCoordinates(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude), query: searchBar.text ?? "")
        
        places?.start(block: { request, data, error in
            guard error == nil, data is NMADiscoveryPage, let resultPage = data as? NMADiscoveryPage else {
                print ("invalid type returned \(String(describing: data))")
                return
            }
            self.locationResults = resultPage.discoveryResults
            self.tableView.reloadData()
        })
    }
        
}
extension LocationResultsTableViewController {

    func configureSearchBar() {
        searchBar = SearchBar(delegate: self)
        guard let searchBar = self.searchBar else  { return }
        searchBar.becomeFirstResponder()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.tableHeaderView = searchBar
        searchBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: Spacing.L).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        searchBar.trailingAnchor.constraint(equalTo:self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
}
    // MARK: - Table view data source
extension LocationResultsTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.locationResults?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.cellHeight
    }
}
    // MARK: - Table view delegate
extension LocationResultsTableViewController {

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? LocationTableViewCell else { return UITableViewCell() }

        cell.name = self.locationResults?[indexPath.row].name
        cell.distance = self.locationResults?[indexPath.row].url

        return cell
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? LocationTableViewCell, let url = cell.distance else { return }
        let detailPage = LocationDetailViewController(url: url)
        self.navigationController?.pushViewController(detailPage, animated: true)
    }
}


extension LocationResultsTableViewController: NMAResultListener {
    func requestDidComplete(_ request: NMARequest, data: Any?, error: Error?) {
        
        print(request)
        print("terminou request")
    }
    
    override func beginRequest(with context: NSExtensionContext) {
        print(context)
    }
}
