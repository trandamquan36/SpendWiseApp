import UIKit

class ItemDetailViewController: UIViewController {
    
    
    @IBOutlet weak var imageCategories: UIImageView!
    @IBOutlet weak var categories: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var detail: UILabel!
    
    var selectedItem:(description:String,amount:String ,date:String,image:UIImage?)?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let selectedItem = selectedItem{
            imageCategories.image = selectedItem.image
            date.text = selectedItem.date
            amount.text = "\(selectedItem.amount)"
            detail.text = selectedItem.description
        }
        // Do any additional setup after loading the view.
    }
    
    
    
    
}
