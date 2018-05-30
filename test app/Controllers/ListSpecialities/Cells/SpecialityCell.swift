//
//  SpicialityCellTableViewCell.swift
//  test app
//
//  Created by iosnuk on 29.05.2018.
//  Copyright © 2018 PlatinumKiller. All rights reserved.
//

import UIKit

class SpecialityCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var backgroundCustomView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        backgroundCustomView.layer.cornerRadius = 5
//        backgroundCustomView.clipsToBounds = true
//        backgroundCustomView.backgroundColor = #colorLiteral(red: 0.4756349325, green: 0.4756467342, blue: 0.4756404161, alpha: 1)
//
//        titleLabel.textColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    func setTitle(title:String){
        titleLabel.text = title
    }
    
}
