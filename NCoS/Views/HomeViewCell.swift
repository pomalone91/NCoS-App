//
//  HomeViewCell.swift
//  NCoS
//
//  Created by Paul Malone on 12/1/20.
//  Copyright © 2020 Paul Malone. All rights reserved.
//

import UIKit
import Down

class HomeViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    /**
     Load the downview into the cell
     */
    func update(with downView: DownView) {
        self.addSubview(downView)
    }

}
