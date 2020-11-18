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
    let address: String
    var articles: [Article] {
        var a = [Article]()
        guard let url = URL(string: address) else {
            print("Unable to create URL from addres: \(address)")
            return self.articles
        }
        let json = getJson(from: url)
        if let json = parseKeys(from: json) {
            for dict in json {
                a.append(Article(dict)) // Append an article built from json dictionary
            }
        }
        
        return a
    }
    
    /**
     Init from a string
     */
    init(string: String) {
        self.address = string
    }

}
