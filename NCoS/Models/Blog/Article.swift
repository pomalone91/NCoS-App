//
//  Article.swift
//  NCoS
//
//  Created by Paul Malone on 11/11/20.
//  Copyright © 2020 Paul Malone. All rights reserved.
//

import Foundation
import UIKit
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
    
    /**
     Get all images from server for this article
     */
    func downloadImages() {
        // Download images
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
// MARK: - Private Helper Functions
extension Article {
    /**
     Grab image ID from server
     */
    private func imageFileNames() -> [String] {
        var fileNames = [String]()
        // Make request to http://localhost/plog_cms_test/api/img-article-map.php?id= to get images for this article's id
        let address = "http://localhost/plog_cms_test/api/img-article-map.php?id=\(self.id)"
        guard let url = URL(string: address) else {
            print("Unable to create URL from addres: \(address)")
            return fileNames
        }
        let json = getJson(from: url)
        if let json = parseKeys(from: json) {
            for dict in json {
                if let id = dict["filename"] as? String {
                    fileNames.append(id)  // Append id to array if possible
                }
            }
        }
        
        return fileNames
    }
    
    /**
     Download an image from the server to DownView.bundle. Files are downloaded from http://ninecirclesofshell.com/images/
     */
    private func downloadImg(with filename: String) -> UIImage? {
        let imgUrl = URL(fileURLWithPath: "http://ninecirclesofshell.com/images/\(filename)")
        
        if let data = try? Data(contentsOf: imgUrl) {
            if let img = UIImage(data: data) {
                return img
            }
        }
        
        // Now that I have an image I need to actually move it to DownView.bundle so the DownView can see it
        return nil
    }
}
