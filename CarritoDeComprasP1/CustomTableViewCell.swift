//
//  CustomTableViewCell.swift
//  CarritoDeComprasP1
//
//  Created by Emiliano Alfredo Martínez Vázquez on 3/30/19.
//  Copyright © 2019 Emiliano Alfredo Martínez Vázquez All rights reserved.

import UIKit

class CustomTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //set background
        self.backgroundColor = .clear
        // Ajustando el image view
        self.imageView?.frame = CGRect(x: 10, y: -10, width: 120, height: 120)
        self.imageView?.contentMode = .scaleAspectFit
        // Ajustando posicion del text label y el detail text label
        self.textLabel?.frame = CGRect(x: 150, y: 0, width: self.frame.width - 120, height: 30)
        self.detailTextLabel?.frame = CGRect(x: 150, y: 28, width: self.frame.width - 45, height: 15)
        //seteando letra del text label
        self.textLabel?.font = UIFont(name: "Arial", size: 25.0)
        self.textLabel?.textColor = .white
        self.detailTextLabel?.textColor = .white
    }

}
