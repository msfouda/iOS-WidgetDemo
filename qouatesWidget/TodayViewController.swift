//
//  TodayViewController.swift
//  qouatesWidget
//
//  Created by Mohamed Sobhi  Fouda on 8/2/18.
//  Copyright © 2018 CareerFoundry. All rights reserved.
//

import UIKit
import NotificationCenter
import QouatesNetworking

class TodayViewController: UIViewController, NCWidgetProviding {
    
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    let networking = Networking()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.quoteLabel.text = nil
        self.authorLabel.text = nil
        
        networking.randomMoviesQuote { (quote, error) in
            if let quote = quote {
                DispatchQueue.main.async {
                    self.quoteLabel.text = quote.text
                    self.authorLabel.text = quote.author
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdate(completionHandler: @escaping (NCUpdateResult) -> Void) {
        networking.randomMoviesQuote { (quote, error) in
            guard let quote = quote, error == nil else {
                completionHandler(.failed)
                return
            }
            
            DispatchQueue.main.async {
                self.quoteLabel.text = quote.text
                self.authorLabel.text = quote.author
            }
            
            completionHandler(.newData)
        }
    }
    
}
