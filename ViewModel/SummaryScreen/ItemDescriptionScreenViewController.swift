import UIKit

class ItemDescriptionScreenViewController: UIViewController {
    
    @IBOutlet private weak var image: UIImageView!
    
    @IBOutlet private weak var categoryLabel: UILabel!
    
    @IBOutlet private weak var dateTextField: DesignableTextField!
    
    @IBOutlet private weak var titleTextField: DesignableTextField!
    
    
    @IBOutlet private weak var amountTextField: DesignableTextField!
    
    
    
    @IBOutlet private weak var descriptionTextView: DesignableTextView!
    
    
    @IBAction private func closeButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil )
    }
    
    var selectedItem:(id: UUID, title:String, date:String, amount:String, category:String, description:String, image:UIImage?)?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let currentItem = selectedItem else { return }
       
        image.image = currentItem.image
        categoryLabel.text = currentItem.category
        dateTextField.text = currentItem.date
        titleTextField.text = currentItem.title
        amountTextField.text = currentItem.amount
        descriptionTextView.text = currentItem.description
        
        
        
        // Do any additional setup after loading the view.
    }
    
   
    
    
    
}
