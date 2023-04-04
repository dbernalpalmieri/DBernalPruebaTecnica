//
//  ClaveCell.swift
//  DBernalPruebaTecnica
//
//  Created by MacBookMBA1 on 31/03/23.
//

import UIKit

class ClaveCell: UITableViewCell {
    
    @IBOutlet weak var labelClave : UILabel!
    
    static let identifier = "ClaveCell"
    
    static let nib = UINib(nibName: "ClaveCell", bundle: .main)

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
