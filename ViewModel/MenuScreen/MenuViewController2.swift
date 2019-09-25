
//
//  MenuViewController.swift
//  SpendWiseApp
//
//  Created by Jason Mach on 9/18/19.
//  Copyright © 2019 Quan Tran. All rights reserved.
//

import UIKit

class MenuViewController2: UIViewController {
    
    @IBOutlet weak var backingView: UIView!
    @IBOutlet weak var cardLeftAnchor: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        backingView.alpha = 0
        cardLeftAnchor.constant = -self.view.frame.width
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.swipeInCard()
    }
    
    
    func swipeInCard() {
        cardLeftAnchor.constant = 0
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
            self.backingView.alpha = 0.5
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    @IBAction func FeedBackButton(_ sender: Any) {
        let feedBackVC = storyboard?.instantiateViewController(withIdentifier: "FeedbackViewController") as! FeedbackViewController
        let rootNav = UINavigationController(rootViewController: feedBackVC)
        self.present(rootNav, animated: true, completion: nil)
    }
    
    @IBAction func AboutButton(_ sender: Any) {
        let aboutVC = storyboard?.instantiateViewController(withIdentifier: "AboutViewController") as! AboutViewController
        let rootNav = UINavigationController(rootViewController: aboutVC)
        self.present(rootNav, animated: true, completion: nil)
    }
    @IBAction func dismissMenu() {
        cardLeftAnchor.constant = -self.view.frame.width
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
            self.backingView.alpha = 0
            self.view.layoutIfNeeded()
        }, completion: { (_) in
            self.dismiss(animated: false, completion: nil)
        })
    }
    
    @IBAction func clickSettings(_ sender: UIButton) {
        let settingsVC = storyboard?.instantiateViewController(withIdentifier: "SettingsTableViewController2") as! SettingsTableViewController2
        let rootNav = UINavigationController(rootViewController: settingsVC)
        self.present(rootNav, animated: true, completion: nil)
    }
    
    
    
}
