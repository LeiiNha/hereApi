//
//  LocationTableViewCell.swift
//  hereApi
//
//  Created by Erica Geraldes on 15/06/2019.
//  Copyright © 2019 Erica Geraldes. All rights reserved.
//

import UIKit

class LocationTableViewCell: UITableViewCell {

    var name: String? {
        didSet {
            nameLabel.text = name
        }
    }
    var distance: String?
    
    private let nameLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: FontSize.S)
        lbl.textAlignment = .left
        return lbl
    }()

    static var reuseIdentifier: String = "LocationTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = Colors.primary.withAlphaComponent(0.3)
        addSubview(nameLabel)
        setAnchors()
    }
    
    private func setAnchors() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: Spacing.S).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: Spacing.S).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: Spacing.S).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

