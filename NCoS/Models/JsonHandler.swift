//
//  JsonHandler.swift
//  NCoS
//
//  Created by Paul Malone on 11/15/20.
//  Copyright © 2020 Paul Malone. All rights reserved.
//

import Foundation

/**
Returns json data from the download URL
- Parameters url: A URL to the download API endpoint.
*/
func getJson(from url: URL) -> Any? {
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
 Parses data components into dictionary from JSON data.
 */
func parseKeys(from data: Any?) -> [[String : Any]]? {
   // Get data if there is any
   guard let json = data else { return nil }
   guard let jsonArray = json as? [[String: Any]] else { return nil }
   
   return jsonArray
}
