//
//  ThirdSignupScreenViewController.swift
//  SpendWiseApp
//
//  Created by Quan Tran on 15/9/19.
//  Copyright © 2019 Quan Tran. All rights reserved.
//

import UIKit

class ThirdSignupScreenViewController: UIViewController {
    //Variables
    private let viewModel = ThirdSignupScreenViewModel()
    private let alert = Alert()
    private var userInfo:(name:String, username:String, password:String, confirmPassword:String)?
    private var userPinNumber:(firstPin:String, secondPin:String, thirdPin:String, fourthPin:String)?
    
    //UI Elements
    @IBAction private func beginButton(_ sender: Any) {
        TempData.comeFromSignupScreen = true
        performSegue(withIdentifier: "Signup3_CameraScreen", sender: self)
    }
    
    @IBAction private func backButton(_ sender: Any) {
        performSegue(withIdentifier: "Signup3_Signup2", sender: self)
    }
    @IBAction private func doneButton(_ sender: Any) {
        if TempData.facialRecognitionAdded == true {
            // save into core data
            addNewUser()
            //Remove temporary data and return to login screen
            TempData.resetUserData()
            TempData.facialRecognitionAdded = false
            performSegue(withIdentifier: "Signup3_LoginScreen", sender: self)
           
        } else {
            alert.showNoFacialRecognitionAlert(on: self)
        }
        
    }
    
    
    @IBAction private func cancelBarButton(_ sender: Any) {
        TempData.resetUserData()
        TempData.facialRecognitionAdded = false
        performSegue(withIdentifier: "Signup3_LoginScreen", sender: self)
    }
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    // ---------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        print("\(TempData.facialRecognitionAdded)")
        if TempData.facialRecognitionAdded == true {
            showSucessAddingFacialRecognition(message: "Success!")
        }
    }
    

    // ---------------------------------------------------------
    // Overrided functions
    // Restrict user from rotating to landscape
    override open var shouldAutorotate: Bool {
        return false
    }
    
    
    // ---------------------------------------------------------
    // Normal functions
    
    private func showSucessAddingFacialRecognition(message:String){
        image.image = UIImage(named: "validIcon")
        label.text = message
        label.textColor = Colors.getColor(redColor: 65.0, greenColor: 173.0, blueColor: 173.0, alpha: 100.0)
    }
    
    private func addNewUser(){
        userInfo = viewModel.retrieveTempUserInfo()
        userPinNumber = viewModel.retrievePinNumber()
        
        guard let name = userInfo?.name, let username = userInfo?.username,
              let password = userInfo?.password,
              let firstPin = userPinNumber?.firstPin, let secondPin = userPinNumber?.secondPin,
              let thirdPin = userPinNumber?.thirdPin, let fourthPin = userPinNumber?.fourthPin
            else { return }
       
        let userPin:String = firstPin + secondPin + thirdPin + fourthPin
        
        viewModel.addUser(name: name, username: username, password: password, pinNumber: userPin)
    }
}
