//
//  BundleHelper.swift
//  NCoS
//
//  Created by Paul Malone on 11/20/20.
//  Copyright © 2020 Paul Malone. All rights reserved.
//

import Foundation

func getDownBundle() -> Bundle? {
    guard let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
        print("getDownBundle failed: Unable to find documents directory")
        return nil
    }
    
    let bundlePath = documents.appendingPathComponent("DownView.bundle")
    guard let bundle = Bundle(url: bundlePath) else {
        print("getDownBundle failed: Unable to create bundle")
        return nil
    }
    
    return bundle
}
