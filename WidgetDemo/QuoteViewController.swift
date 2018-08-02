//
//  ViewController.swift
//  WidgetDemo
//
//  Updated by Mohamed Sobhi Fouda on 8/2/18.
//  Created by Hesham Abd-Elmegid on 6/27/16.
//  Copyright © 2016 CareerFoundry. All rights reserved.
//

import UIKit

class QuoteViewController: UIViewController {

    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let networking = Networking()

    override func viewDidAppear(_ animated: Bool) {
        getNewQuote()
    }
    
    func getNewQuote() {
        networking.randomMoviesQuote { (quote, error) in
            if let quote = quote {
                DispatchQueue.main.async {
                    self.quoteLabel.text = quote.text
                    self.authorLabel.text = quote.author
                    self.activityIndicator.stopAnimating()
                }
            }
        }
    }
    
    @IBAction func newQuoteButtonTapped(_ sender: AnyObject) {
        quoteLabel.text = nil
        authorLabel.text = nil
        activityIndicator.startAnimating()
        getNewQuote()
    }
}

