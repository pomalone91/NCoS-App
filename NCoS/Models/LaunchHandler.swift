//
//  LaunchHandler.swift
//  NCoS
//
//  Created by Paul Malone on 11/17/20.
//  Copyright © 2020 Paul Malone. All rights reserved.
//

import Foundation

struct LaunchHandler {
    /**
     Checks if this is the user's first time launching the app. If it is, will need to write a new DownView.bundle
     */
    func firstLaunch() -> Bool {
        UserDefaults.standard.set(false, forKey: "launchedBefore")
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        if launchedBefore  {
            print("Not first launch.")
            return false
        } else {
            print("First launch, setting NSUserDefault.")
//            UserDefaults.standard.set(true, forKey: "launchedBefore")
            return true
        }
    }
    
    /**
     Copy DownView.bundle to documents directory so that it is writable
     */
    func writeNewBundle() {
        // Grab the DownView.bundle from resources and write it to documents directory
        guard let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        guard let bundleURL = Bundle.main.url(forResource: "DownView", withExtension: ".bundle") else { return }
//        print(bundleURL.absoluteString)
        let destination = documents.appendingPathComponent("DownView.bundle")
//        print(destination.absoluteString)
        let fm = FileManager.default
        
        if !fm.fileExists(atPath: destination.path) {
//            print("Writing DownView.bundle")
            try! fm.copyItem(at: bundleURL, to: destination)
        }
        
        let contents = try! fm.contentsOfDirectory(at: destination, includingPropertiesForKeys: nil, options: .includesDirectoriesPostOrder)
//        print("----------printing document contents----------")
//        print(contents)
        
        // Write a new "images" folder in doc directory
        let imagePath = destination.appendingPathComponent("images")
//        print(imagePath.absoluteString)
        do {
            try fm.createDirectory(at: imagePath, withIntermediateDirectories: false, attributes: nil)
        } catch {
            print("images folder already exists")
        }
//        if !fm.fileExists(atPath: imagePath.absoluteString) {
//            print("Writing images folder")
//            try! fm.createDirectory(at: imagePath, withIntermediateDirectories: false, attributes: nil)
//        }
        
//        let contents = try! fm.contentsOfDirectory(atPath: imagePath.absoluteString)
        
//        print(contents)
//        print(FileManager.default.contentsOfDirectory(atPath: imagePath)
    }
}
