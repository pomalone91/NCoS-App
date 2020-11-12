//
//  ViewController.swift
//  NCoS
//
//  Created by Paul Malone on 11/11/20.
//  Copyright © 2020 Paul Malone. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // See if we can load the articles
        guard let url = URL(string: "http://ninecirclesofshell.com/get-service.php") else {
            print("Failed to create URL object")
            return
        }
        var blog = Blog(url: url)
        let articles = blog.fetchArticles()
        
        for article in articles {
            print(article.contents)
        }
    }
}

