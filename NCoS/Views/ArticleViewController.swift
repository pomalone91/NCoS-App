//
//  ArticleViewController.swift
//  NCoS
//
//  Created by Paul Malone on 11/12/20.
//  Copyright © 2020 Paul Malone. All rights reserved.
//

import UIKit
import WebKit
import Down

class ArticleViewController: UIViewController {
    var article: Article?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = article?.title
        article?.downloadImages()
        
        guard let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let bundlePath = documents.appendingPathComponent("DownView.bundle")
        
        guard let bundle = Bundle(url: bundlePath) else{ return }
        
        if let contents = article?.contents {
            if let articleView = try? DownView(frame: self.view.bounds, markdownString: contents, openLinksInBrowser: true, templateBundle: bundle, writableBundle: true, configuration: nil, options: .default, didLoadSuccessfully: nil) {//DownView(frame: self.view.bounds, markdownString: contents) {
                self.view.addSubview(articleView)
            }
        }
    }
    

    // MARK: - Navigation

//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }

}
