//
//  HomeViewCell.swift
//  NCoS
//
//  Created by Paul Malone on 12/1/20.
//  Copyright © 2020 Paul Malone. All rights reserved.
//

import UIKit
import Down
import WebKit

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
        for view in self.subviews {
            if let dv = view as? DownView {
                dv.removeFromSuperview()
            }
        }

        self.addSubview(downView)
        
        for view in self.subviews {
            if let dv = view as? DownView {
                dv.reload()
            }
        }
    }
    
    func update(with article: Article, bundle: Bundle) {
        if let dv = try? DownView(frame: self.contentView.bounds, markdownString: article.contents, openLinksInBrowser: true, templateBundle: bundle, writableBundle: true, configuration: nil, options: .default, didLoadSuccessfully: nil) {
            self.addSubview(dv)
        }
    }

}
