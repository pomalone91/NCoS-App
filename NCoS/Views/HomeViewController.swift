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
class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, WKNavigationDelegate {
    
    @IBOutlet var tableView: UITableView!
    
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
        
        // Load downViews
        for article in articles {
            if let dv = try? DownView(frame: self.view.bounds, markdownString: article.contents, openLinksInBrowser: true, templateBundle: bundle, writableBundle: true, configuration: nil, options: .default, didLoadSuccessfully: nil) {
//                dv.scrollView.isScrollEnabled = false
//                dv.scrollView.bounces = false
                dv.navigationDelegate = self
//                dv.webView(dv, didFinish: .none)
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
        let downView = downViews[indexPath.row]
        downView.reload()
//        print("bounds.height: \(downView.bounds.height)")
//        print("contentSize.height: \(downView.scrollView.contentSize.height)")
//        return downView.bounds.height
//        return downViews[indexPath.row].scrollView.contentSize.height
//        webView(downView, didFinish: .some(.init()))
//        print(contentHeight)
        return contentHeight
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Make cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath) as! HomeViewCell
        
        
        // Make DownView
//        let article = articles[indexPath.row]
//        guard let downView = try? DownView(frame: cell.contentView.bounds, markdownString: article.contents, openLinksInBrowser: true, templateBundle: bundle, writableBundle: true, configuration: nil, options: .default, didLoadSuccessfully: nil) else {
//            return cell
//        }
        
//        print(indexPath.section)
        // Add downView to cell
        cell.update(with: downViews[indexPath.section])
//        cell.update(with: articles[indexPath.section], bundle: bundle)
        
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

// MARK: - Extension to set webView height
extension HomeViewController {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("Content Height \(webView.scrollView.contentSize.height)");
        let height =  webView.scrollView.contentSize.height
        self.contentHeight = height - 720
        webView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: height)
        self.tableView.reloadData()
    }
}

//
//extension DownView {
//    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//        self.webView.evaluateJavaScript("document.readyState", completionHandler: { (complete, error) in
//            if complete != nil {
//                self.webView.evaluateJavaScript("document.body.scrollHeight", completionHandler: { (height, error) in
//                    self.containerHeight.constant = height as! CGFloat
//                })
//            }
//
//            })
//    }
//}
