//
//  AnasayfaCell.swift
//  Emlak2
//
//  Created by tolgahan sonmez on 27.01.2023.
//

import UIKit

class AnasayfaCell: UITableViewCell {
    
    
    @IBOutlet weak var aciklaText: UILabel!
    
    @IBOutlet weak var fiyatText: UILabel!
    
    @IBOutlet weak var semtText: UILabel!
    
    @IBOutlet weak var odaText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
