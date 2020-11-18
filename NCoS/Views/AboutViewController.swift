//
//  AboutViewController.swift
//  NCoS
//
//  Created by Paul Malone on 11/12/20.
//  Copyright © 2020 Paul Malone. All rights reserved.
//

import UIKit
import WebKit

class AboutViewController: UIViewController {

    @IBOutlet var aboutView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let myURL = URL(string:"http://ninecirclesofshell.com/about.php")
        let myRequest = URLRequest(url: myURL!)
        aboutView.load(myRequest)


        // Do any additional setup after loading the view.
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
