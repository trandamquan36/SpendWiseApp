//
//  ExpandableHeaderViewNew.swift
//  SpendWiseApp
//
//  Created by Quan Tran on 22/9/19.
//  Copyright © 2019 Quan Tran. All rights reserved.
//



import UIKit

protocol ExpandableHeaderViewDelegate {
    func toggleSection(header:ExpandableHeaderViewNew,section: Int)
}

class ExpandableHeaderViewNew: UITableViewHeaderFooterView {
    @IBOutlet weak var HeaderImageView: UIImageView!
    var delegate: ExpandableHeaderViewDelegate?
    var section: Int!
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier:reuseIdentifier)
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectHeaderAction)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func selectHeaderAction(gestureRecognizer:UITapGestureRecognizer) {
        let cell = gestureRecognizer.view as! ExpandableHeaderViewNew
        delegate?.toggleSection(header: self, section: cell.section)
    }
    
    
    func customInit(type:String, section: Int, delegate: ExpandableHeaderViewDelegate) {
        self.textLabel?.text = type
        self.section = section
        self.delegate = delegate
        //self.HeaderImageView? = UIImage(
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if (self.textLabel?.text == "Expenses") {
            self.textLabel?.textColor = Colors.getColor(redColor: 255, greenColor: 99, blueColor: 71, alpha: 0.95)
            
        }
        else
        {
            self.textLabel?.textColor = Colors.getColor(redColor: 50, greenColor: 205, blueColor: 50, alpha: 1)
        }
        
        self.contentView.backgroundColor = Colors.getColor(redColor: 60, greenColor: 71, blueColor: 100, alpha: 1)
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }
    
    
  
    
}
