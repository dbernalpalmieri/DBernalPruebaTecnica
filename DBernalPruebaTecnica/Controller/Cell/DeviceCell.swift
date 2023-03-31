//
//  DeviceCell.swift
//  DBernalPruebaTecnica
//
//  Created by MacBookMBA1 on 30/03/23.
//

import UIKit

class DeviceCell: UITableViewCell {
    
    @IBOutlet weak var labelDeviceName : UILabel!
    @IBOutlet weak var labelIdentifier : UILabel!
    
    static let identifier = "DeviceCell"
    static let nib = UINib(nibName: "DeviceCell", bundle: .main)

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
