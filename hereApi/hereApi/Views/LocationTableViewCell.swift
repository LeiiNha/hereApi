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
    var distance: String? {
        didSet {
            distanceLabel.text = distance
        }
    }
    
    private let nameLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.textAlignment = .left
        return lbl
    }()
    
    
    private let distanceLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textAlignment = .right
        lbl.numberOfLines = 0
        return lbl
    }()

    static var reuseIdentifier: String = "LocationTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = Colors.primary.withAlphaComponent(0.3)
        addSubview(nameLabel)
        addSubview(distanceLabel)
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

