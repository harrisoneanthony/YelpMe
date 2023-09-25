//
//  RestaurantCell.swift
//  YelpMe
//
//  Created by Harrison Anthony on 8/2/23.
//

import UIKit

class RestaurantCell: UITableViewCell {
    
    @IBOutlet var name: UILabel!
    @IBOutlet var address1: UILabel!
    @IBOutlet var cityStateZip: UILabel!
    @IBOutlet var url: UILabel!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        self.name.font = UIFont(name: "HelveticaNeue-Bold",
                                size: 20.0)
        self.address1.font = UIFont(name: "HelveticaNeue",
                                size: 18.0)
        self.cityStateZip.font = UIFont(name: "HelveticaNeue",
                                size: 18.0)
        self.url.font = UIFont(name: "HelveticaNeue",
                                size: 18.0)
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        
    }
}

