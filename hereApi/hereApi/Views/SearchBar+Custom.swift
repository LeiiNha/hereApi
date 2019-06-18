//
//  SearchBar.swift
//  hereApi
//
//  Created by Erica Geraldes on 15/06/2019.
//  Copyright © 2019 Erica Geraldes. All rights reserved.
//

import UIKit

final class SearchBar: UISearchBar {

    init(delegate: UISearchBarDelegate) {
        super.init(frame: CGRect.zero)
        self.delegate = delegate
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func draw(_ rect: CGRect) {
        super.draw(rect)

        self.placeholder = "Search for your location :)"
        self.barTintColor = Colors.primary
        self.searchBarStyle = UISearchBar.Style.prominent
        self.isTranslucent = false
    }
}
