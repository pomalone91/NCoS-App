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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        // Get blog and articles
        let blog = Blog(string: "http://ninecirclesofshell.com/api/get-service.php")
        articles = Array(blog.articles.sorted(by: <).prefix(5))
        
        // Set row height
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableView.automaticDimension
//        // Create a vertical stackView
//        var stackView = UIStackView()
//        stackView.axis = .vertical
//        stackView.distribution = .equalSpacing
//        stackView.alignment = .center
//        stackView.spacing = 5
        
        
        
        // Loop thru first 5 articles and create downviews for them, adding each to our stackView
//        for i in 0..<5 {
//            let view = UIView()
//            view.heightAnchor.constraint(equalToConstant: 100).isActive = true
//            view.widthAnchor.constraint(equalToConstant: 120).isActive = true
//
//
//            if let downView = try? DownView(frame: view.bounds, markdownString: articles[i].contents, openLinksInBrowser: true, templateBundle: bundle, writableBundle: true, configuration: nil, options: .default, didLoadSuccessfully: nil) {
//                view.addSubview(downView)
//                stackView.addArrangedSubview(view)
//            }
//        }
//        self.view.addSubview(stackView)
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
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Make cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath) as! HomeViewCell
        guard let bundle = getDownBundle() else {
            print("Unable to load bundle in cellView")
            return cell
        }
        
        // Make DownView
        let article = articles[indexPath.row]
        guard let downView = try? DownView(frame: cell.contentView.bounds, markdownString: article.contents, openLinksInBrowser: true, templateBundle: bundle, writableBundle: true, configuration: nil, options: .default, didLoadSuccessfully: nil) else {
            return cell
        }
        
        // Add downView to cell
        cell.update(with: downView)
        
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
