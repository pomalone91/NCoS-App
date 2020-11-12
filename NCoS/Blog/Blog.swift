//
//  Blog.swift
//  NCoS
//
//  Created by Paul Malone on 11/11/20.
//  Copyright © 2020 Paul Malone. All rights reserved.
//

import Foundation
/**
 A structure that describes a blog. This will handle fetching and storing blog entries and other data needed to display the blog in the app.
 */
struct Blog {
    let url: URL
    private var articles = [Article]()
    
    /**
     Init blog with a URL
     */
    init(url: URL) {
        self.url = url
    }
    
    /**
     Fetches articles from the blog's URL
     */
    mutating func fetchArticles() -> [Article] {
        let json = getJson(from: self.url)
        if let json = parseArticles(from: json) {
            for dict in json {
                self.articles.append(Article(dict)) // Append an article built from json dictionary
            }
        }
        
        return self.articles
    }
}

// MARK: - Private Helper Functions
extension Blog {
    /**
    Returns json data from the download URL
    - Parameters url: A URL to the download API endpoint.
    */
    private func getJson(from url: URL) -> Any? {
        var data: Data?
        var json: Any?
        do {
            data = try Data(contentsOf: url)
            guard let jsonData = data else { return nil }
            json = try JSONSerialization.jsonObject(with: jsonData)
        } catch {
            // contents could not be loaded
            return nil
        }
        return json
    }
    
    /**
     Parses article components into dictionary from JSON data.
     */
    private func parseArticles(from data: Any?) -> [[String : Any]]? {
        // Get data if there is any
        //        guard let json = Downloader.getJson() else { return nil }
        guard let json = data else { return nil }
        guard let jsonArray = json as? [[String: Any]] else { return nil }
        
        return jsonArray
    }
}
