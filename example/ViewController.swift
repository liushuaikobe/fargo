//
//  ViewController.swift
//  fargo
//
//  Created by Shuai Liu on 16/1/8.
//  Copyright © 2016年 vars.me. All rights reserved.
//

import UIKit
import fargo

class ViewController: UIViewController {

    @IBOutlet weak var urlTextField: UITextField!
    
    @IBOutlet weak var googlResultLabel: UILabel!
    @IBOutlet weak var tcnResultLabel: UILabel!
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    var i = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func fargoAction(sender: AnyObject) {
        
        if let url = urlTextField.text {
            self.indicator.startAnimating()
            self.googlResultLabel.text = nil
            self.tcnResultLabel.text = nil;
            
            GooglFargoTask("AIzaSyBSwbXhKQFzeD7PKH1XLfHLQkjRZNkjo-k").shorten(url).success {
                origin, shorten in
                self.setResult(shorten, forResultLabel: self.googlResultLabel)
            }.error {
                error in
                self.setError(error, forResultLabel: self.googlResultLabel)
            }.fargo()
            
            TcnFargoTask("3050340951").shorten(url).success {
                origin, shorten in
                self.setResult(shorten, forResultLabel: self.tcnResultLabel)
            }.error {
                error in
                self.setError(error, forResultLabel: self.tcnResultLabel)
            }.fargo()
            
        }
        
    }
    
    func setResult(result: String, forResultLabel label: UILabel) {
        label.text = result
        self.i += 1
        if self.i == 2 {
            self.indicator.stopAnimating()
        }
    }
    
    func setError(error: NSError?, forResultLabel label: UILabel) {
        label.text = "Error"
        self.i += 1
        if self.i == 2 {
            self.indicator.stopAnimating()
        }
    }

}

