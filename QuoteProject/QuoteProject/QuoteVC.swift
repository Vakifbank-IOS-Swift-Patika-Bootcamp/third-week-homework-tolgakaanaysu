//
//  ViewController.swift
//  QuoteProject
//
//  Created by Tolga Kağan Aysu on 20.11.2022.
//

import UIKit
import MaterialActivityIndicator

final class QuoteVC: UIViewController {
    
    @IBOutlet private weak var authorLabel: UILabel!
    @IBOutlet private weak var quotesLabel: UILabel!
    @IBOutlet private weak var newQuoteButton: UIButton!
    let indicator = MaterialActivityIndicatorView()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        newQuoteButton.isHidden = true
        authorLabel.text = ""
        quotesLabel.text = ""
        
        setupActivityIndicatorView()
        getQuotes()
    }
    
    //MARK: - IBActions
    @IBAction func newQuotesButtonClicked(_ sender: Any) {
        getQuotes()
    }
    
    //MARK: - Private methods
    private func getQuotes(){
        indicator.startAnimating()
        Client.getQuotes {[weak self] quotes, error in
            guard
                let quotes,
                let self
            else {
                print(error!)
                return
            }
            
            DispatchQueue.main.async {
                self.authorLabel.text = quotes.author
                self.quotesLabel.text = quotes.en
                self.newQuoteButton.isHidden = false
                self.indicator.stopAnimating()
            }
          
           
        }
    }
    
    //setup activity indicator
    private func setupActivityIndicatorView() {
          view.addSubview(indicator)
          setupActivityIndicatorViewConstraints()
      }
      
      private func setupActivityIndicatorViewConstraints() {
          indicator.translatesAutoresizingMaskIntoConstraints = false
          indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
          indicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
      }
}

