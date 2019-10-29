//
//  AboutViewController.swift
//  BullsEye
//
//  Created by MacStudent on 2019-10-28.
//  Copyright © 2019 MacStudent. All rights reserved.
//

import UIKit
class AboutViewController: UIViewController {
    
    
    @IBOutlet weak var webView: UIWebView!
    
    @IBAction func closeBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = Bundle.main.url(forResource: "BullsEye",
                                     withExtension: "html") {
            if let htmlData = try? Data(contentsOf: url) {
                let baseURL = URL(fileURLWithPath: Bundle.main.bundlePath)
                webView.load(htmlData, mimeType: "text/html",
                             textEncodingName: "UTF-8",
                             baseURL: baseURL)
            }
        }
    }
}



