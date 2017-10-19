
//
//  LampTableViewCell.swift
//  MinMADPhilipsHueIOS
//
//  Created by Ferdinand van Disseldorp on 19/10/2017.
//  Copyright © 2017 Ferdinand van Disseldorp. All rights reserved.
//

import UIKit

class LampTableViewCell: UITableViewCell {

    @IBOutlet weak var LabelLampId: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
