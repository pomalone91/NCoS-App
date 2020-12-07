//
//  HomeViewController.swift
//  NCoS
//
//  Created by Paul Malone on 11/19/20.
//  Copyright © 2020 Paul Malone. All rights reserved.
//

import UIKit
import Down
import WebKit

/**
 This will be the primary view for the tab contr@objc @objc oller. This will show the five most recently published articles. I think I can add a stack view and then programatically add downViews for each article
 */
class HomeViewController: UIViewController, WKNavigationDelegate {
    @IBOutlet var containerView: UIView!
    
    var articles = [Article]()
    var downViews = [DownView]()
    var bundle = Bundle()
    var contentHeight:CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set estimated view height
//        tableView.estimatedRowHeight = 500
        
        // Load the bundle
        bundle = getDownBundle()!
        
        // Get blog and articles
        let blog = Blog(string: "http://ninecirclesofshell.com/api/get-service.php")
        articles = Array(blog.articles.sorted(by: <).prefix(5))
        
        let markdown = homeMarkDownString(from: articles)
        
        if let dv = try? DownView(frame: self.containerView.bounds, markdownString: markdown, openLinksInBrowser: true, templateBundle: bundle, writableBundle: true, configuration: nil, options: .default, didLoadSuccessfully: nil) {
//                print(article.title)
//                dv.scrollView.isScrollEnabled = false
//                dv.scrollView.bounces = false
//            dv.navigationDelegate = self
//                dv.webView(dv, didFinish: .none)
//            downViews.append(dv)
            self.containerView.addSubview(dv)
        }
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

// MARK: - Private Helpers
extension HomeViewController {
    
    /**
     Builds a contiguous Markdown string of all 5 homescreen articles and displays them in one DownView.
     1. Add h1 to top of each string with line break
     2. Download all images for each article
     3. Add --- horizontal breaks between articles
     */
    private func homeMarkDownString(from articles: [Article]) -> String {
        var homeString = ""
        
        for article in articles {
            homeString.append(contentsOf: "# \(article.title)\n")   // Add h1 header from title
            homeString.append(contentsOf: article.contents)
            homeString.append(contentsOf: "\n\n----\n")                   // Add horizontal rule after article
            article.downloadImages()
        }
        return homeString
    }
}
