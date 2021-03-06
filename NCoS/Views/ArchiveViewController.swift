//
//  ViewController.swift
//  NCoS
//
//  Created by Paul Malone on 11/11/20.
//  Copyright © 2020 Paul Malone. All rights reserved.
//

import UIKit

class ArchiveViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var blog = Blog(string: "http://ninecirclesofshell.com/api/get-service.php")
    var articles = [Article]()
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Fetch articles for blog
        articles = blog.articles
    }
    
    // MARK: - Data Source functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath) as! ArchiveTableViewCell
        
        // Grab the article and use it to configure cell
        let article = articles[indexPath.row]
        cell.update(with: article)
        
        return cell
     }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "articleSegue" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let article = articles[indexPath.row]

                // Assign stuff to the view this segue is going to
                let articleView = segue.destination as! ArticleViewController
                articleView.article = article
            }
        }
    }
}

