//
//  Article.swift
//  NCoS
//
//  Created by Paul Malone on 11/11/20.
//  Copyright © 2020 Paul Malone. All rights reserved.
//

import Foundation
/**
 Structure that describes an article object
 */
struct Article: Equatable, Codable {
    // Fields and default values
    var id = ""
    var title = ""
    var summary = ""
    var filename = ""
    var pubDate = Date()
    var contents = ""
    
    // Initalize an article from a dictionary... like JSON
    init(_ dictionary: [String: Any]) {
           self.id = dictionary["id"] as? String ?? ""
           self.title = dictionary["title"] as? String ?? ""
           self.summary = dictionary["summary"] as? String ?? ""
           self.filename = dictionary["filename"] as? String ?? ""
           self.pubDate = dictionary["pubDate"] as? Date ?? Date()
           self.contents = dictionary["markdown"] as? String ?? ""
       }
    
    // MARK: Equatable
    static func ==(lhs: Article, rhs: Article) -> Bool {
        if lhs.filename == rhs.filename {
            return true
        }
        return false
    }
    
    // MARK: TODO make this comparable for sorting and stuff
}
