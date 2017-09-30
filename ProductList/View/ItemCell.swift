//
//  ItemCell.swift
//  ProductList
//
//  Created by Alif on 22/09/2017.
//  Copyright © 2017 Alif. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var thumb: UIImageView!
    
    func configureCell(item: Item) {
        
        titleLabel.text = item.title
        priceLabel.text = "$\(item.price)"
        detailsLabel.text = item.details
        if let img = item.toImage as? Image {
            thumb.image = img.image as? UIImage
        }
        
    }
}
