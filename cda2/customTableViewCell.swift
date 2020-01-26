//
//  customTableViewCell.swift
//  cda2
//
//  Created by Emilio Castro on 1/12/20.
//  Copyright © 2020 Emilio Castro. All rights reserved.
//

import UIKit

class customTableViewCell: UITableViewCell {

    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var cellView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
     
        let uc = #colorLiteral(red: 0.1498670876, green: 0.2153606415, blue: 0.3738780916, alpha: 1)
        self.cellView.backgroundColor = selected ? #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1) : uc
        // Configure the view for the selected state
        
    }
  

}
