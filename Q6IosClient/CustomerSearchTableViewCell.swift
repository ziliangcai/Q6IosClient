//
//  CustomerSearchTableViewCell.swift
//  Q6IosClient
//
//  Created by yang wulong on 14/06/2016.
//  Copyright © 2016 q6. All rights reserved.
//

import UIKit

class CustomerSearchTableViewCell: UITableViewCell {

    @IBOutlet weak var lblCustomerID: UILabel!
    @IBOutlet weak var lblCustomerName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

 
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
