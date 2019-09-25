import UIKit

class ItemDescriptionScreenViewController: UIViewController {
    
    
    @IBOutlet private weak var image: UIImageView!
    @IBOutlet private weak var category: UILabel!
    @IBOutlet private weak var date: UILabel!
    @IBOutlet private weak var amount: UILabel!
    @IBOutlet private weak var detail: UILabel!
    
    var selectedItem:(title:String, date:String, amount:String, category:String, description:String, image:UIImage?)?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let currentItem = selectedItem else { return }
       
        image.image = currentItem.image
        //title.text = currentItem.title
        date.text = currentItem.date
        amount.text = currentItem.amount
        detail.text = currentItem.description
        category.text = currentItem.category
        
        // Do any additional setup after loading the view.
    }
    
   
    
    
    
}
