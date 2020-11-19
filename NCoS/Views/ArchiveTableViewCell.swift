//
//  HomeTableViewCell.swift
//  NCoS
//
//  Created by Paul Malone on 11/12/20.
//  Copyright © 2020 Paul Malone. All rights reserved.
//

import UIKit

class ArchiveTableViewCell: UITableViewCell {

    @IBOutlet var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func update(with article: Article) {
        self.title.text = article.title
    }

}
