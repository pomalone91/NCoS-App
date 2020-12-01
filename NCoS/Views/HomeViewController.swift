//
//  HomeViewController.swift
//  NCoS
//
//  Created by Paul Malone on 11/19/20.
//  Copyright © 2020 Paul Malone. All rights reserved.
//

import UIKit
import Down

/**
 This will be the primary view for the tab controller. This will show the five most recently published articles. I think I can add a stack view and then programatically add downViews for each article
 */
class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    var articles = [Article]()
    var downViews = [DownView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set estimated view height
        tableView.estimatedRowHeight = 500
        
        // Load the bundle
        guard let bundle = getDownBundle() else {
            print("Unable to load bundle in cellView")
            return
        }

        // Get blog and articles
        let blog = Blog(string: "http://ninecirclesofshell.com/api/get-service.php")
        articles = Array(blog.articles.sorted(by: <).prefix(5))
        
        // Load downViews
        for article in articles {
            if let dv = try? DownView(frame: self.view.bounds, markdownString: article.contents, openLinksInBrowser: true, templateBundle: bundle, writableBundle: true, configuration: nil, options: .default, didLoadSuccessfully: nil) {
                dv.reload()
                downViews.append(dv)
            }
        }
        
    }
    
    // MARK: - Section set up
    func numberOfSections(in tableView: UITableView) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return articles[section].title
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    // MARK: - Cell set up
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return downViews[indexPath.row].bounds.height
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Make cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath) as! HomeViewCell
        
        
        // Make DownView
//        let article = articles[indexPath.row]
//        guard let downView = try? DownView(frame: cell.contentView.bounds, markdownString: article.contents, openLinksInBrowser: true, templateBundle: bundle, writableBundle: true, configuration: nil, options: .default, didLoadSuccessfully: nil) else {
//            return cell
//        }
        
        // Add downView to cell
        cell.update(with: downViews[indexPath.row])
        
        return cell
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
}
