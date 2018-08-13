//
//  WebViewController.swift
//  MapView
//
//  Created by Qasim Abbas on 8/6/18.
//  Copyright © 2018 Qasim. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKUIDelegate {
    var urlString: String?
    @IBOutlet weak var webView: WKWebView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(backVC))
        
        

        self.navigationController?.navigationItem.leftBarButtonItem = backButton
        
        print(urlString ?? "NO URL")
        let url = URL(string:String(describing: urlString ?? "http://www.google.com"))
        let request = URLRequest(url: url!)
        webView.load(request)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnMap(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @objc func backVC(){
        
    }

}
