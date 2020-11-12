//
//  ViewController.swift
//  NCoS
//
//  Created by Paul Malone on 11/11/20.
//  Copyright © 2020 Paul Malone. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var blog = Blog(string: "http://ninecirclesofshell.com/get-service.php")
    var articles = [Article]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // See if we can load the articles
//        guard let url = URL(string: "http://ninecirclesofshell.com/get-service.php") else {
//            print("Failed to create URL object")
//            return
//        }
//        var blog = Blog(url: url)
        // Fetch articles for blog
        articles = blog.articles
        
        for article in articles {
            print(article.title)
        }
    }
    
    // MARK: - Data Source functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath) as! HomeTableViewCell
        
        // Grab the article and use it to configure cell
        let article = articles[indexPath.row]
        cell.update(with: article)
        
        return cell
     }
}
