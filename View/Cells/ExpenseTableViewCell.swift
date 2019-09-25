//
//  ExpenseTableViewCell.swift
//  To-Do app
//
//  Created by Bang Mach on 2/9/19.
//  Copyright © 2019 Bang Mach. All rights reserved.
//

import UIKit

class ExpenseTableViewCell: UITableViewCell {
    
    
   // private let viewModel = ViewModel()
    
    
    
    @IBOutlet weak var imagesomething: UIImageView!
    @IBOutlet weak var ExpenseLabel: UILabel!
    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var AmountLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
}
