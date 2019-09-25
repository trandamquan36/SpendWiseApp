//
//  ViewController.swift
//  SpendWiseApp
//
//  Created by Quan Tran on 2/9/19.
//  Copyright © 2019 Quan Tran. All rights reserved.
//

import UIKit
import CoreData

class LoginScreenViewController: UIViewController, UITextFieldDelegate {
    private let viewModel = LoginScreenViewModel()
    private let validation = Validation()
    private let alert = Alert()
   
    //LoginScreen UI elements
    @IBOutlet private weak var signInView: DesignableView!
    @IBOutlet private weak var signUpButton: UIButton!
    @IBOutlet private weak var usernameTextField: DesignableTextField!
    @IBOutlet private weak var passwordTextField: DesignableTextField!
    
    @IBAction func forgotPasswordButton(_ sender: Any) {
        TempData.comeFromLoginScreen = true
        performSegue(withIdentifier: "LoginScreen_FP1", sender: self)
    }
    @IBAction func facialRecognitionButton(_ sender: Any) {
        TempData.comeFromLoginScreen = true
        performSegue(withIdentifier: "LoginScreen_CameraScreen", sender: self)
    }
    
    @IBAction private func loginButton(_ sender: DesignableButton) {
        guard let enteredUsername = usernameTextField.text else { return }
        guard let enteredPassword = passwordTextField.text else { return }
        
        if enteredUsername.isEmpty == true || enteredPassword.isEmpty == true {
            alert.showMissingLoginCredentialsAlert(on: self)
        }
        
        if let index = usernames.firstIndex(of: enteredUsername) {
            if passwords[index] == enteredPassword {
                performSegue(withIdentifier: "LoginScreen_SummaryScreen", sender: self)
                TempData.usernameInput = enteredUsername
                
            } else {
                alert.showInvalidPasswordAlert(on: self)
            }
        } else {
            alert.showInvalidUsernameAlert(on: self)
        }

    }
    
    @IBAction private func signupButton(_ sender: Any) {
        performSegue(withIdentifier: "LoginScreen_Signup1", sender: self)
    }
    
    //LoginScreen variables
    private var textFields:[DesignableTextField] = []
    private var userInfo:(names:[String], usernames:[String], passwords:[String], pins:[String])?
    private var names:[String] = []
    private var usernames:[String] = []
    private var passwords:[String] = []
    private var pins:[String] = []
    
    var container: NSPersistentContainer!
    //
    // ---------------------------------------------------------
    // Lifecycle of ViewController:
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set 'Sign Up?' string to be an attributed string
        setAttributedSignUpString()
        
        // Initialize alpha of the UI elements for animation purposes
        setUIAlpha()
        
        // Begin animation (for better users' experiences)
        UIView.animate(withDuration: 1.5, delay: 0.2, options: .curveEaseOut,
                       animations: {
                        self.animateUIElements()
        }, completion: nil)
        
        // Populate array of text fields
        populateTextFieldArray()
        // Connect all text fields
        UITextField.connectAllTxtFieldFields(txtfields: textFields)
        
        TempData.resetUserData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // retrieve users' information
        retrieveDataFromDatabase()
        // create dummy data
        if checkDataIfExists(dummyUsername: "ValidUsername") == false {
            createDummyData()
            // update again
            retrieveDataFromDatabase()
        }
    }
    

    
    
    
    
    // ---------------------------------------------------------
    // Overrided functions
    // Restrict user from rotating to landscape
    override open var shouldAutorotate: Bool {
        return false
    }
    
    // Change color of Status Bar
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // hide keyboard when user click on the scrollView
    @IBAction private func hideKeyboard(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
  
  
    // ----------------------------------------------------------
    // Normal functions
    private func setUIAlpha(){
        self.signInView.alpha = 0.0
    }
    
    private func animateUIElements(){
        self.signInView.alpha = 1.0
        self.signInView.center.y -= 25.0
    
    }
    
    private func setAttributedSignUpString(){
        let attributedString = NSAttributedString(
                string: "Sign up!",
                attributes: [NSAttributedString.Key.foregroundColor: Colors.getColor(redColor: 255.0, greenColor: 221.0, blueColor: 119.0, alpha: 100.0),
                             NSAttributedString.Key.underlineStyle: 1.0]
                )
        signUpButton!.setAttributedTitle(attributedString, for: .normal)
    }
    
    private func populateTextFieldArray(){
        textFields.append(usernameTextField)
        textFields.append(passwordTextField)
    }
    
    private func retrieveDataFromDatabase(){
        userInfo = viewModel.getDataFromCoreData()
        
        names = userInfo!.names
        usernames = userInfo!.usernames
        passwords = userInfo!.passwords
        pins = userInfo!.pins
    }
    
    private func createDummyData(){
        // create 1 dummy acount
        viewModel.createDummyUserCoreData(name: "YourName", username: "ValidUsername", password: "ValidPassword", pinNumber: "0000")
        // create 2 incomes and 2 expenses
        viewModel.createDummyItemCoreData(id: viewModel.generateID(), title: "Udon Yasan", date: viewModel.getCurrentDate(), amount: "20", type: CustomItemType.expense.name, category: Category.food.name, description: "Eating udon with friends on Friday Night")
        
        viewModel.createDummyItemCoreData(id: viewModel.generateID(), title: "January Rent", date: viewModel.getCurrentDate(), amount: "200", type: CustomItemType.expense.name, category: Category.rent.name, description: "House's rent in January")
        
        viewModel.createDummyItemCoreData(id: viewModel.generateID(), title: "Work Salary 1", date: viewModel.getCurrentDate(), amount: "1000", type: CustomItemType.income.name, category: Category.salary.name, description: "Woa so much money")
        
        viewModel.createDummyItemCoreData(id: viewModel.generateID(), title: "Mom's Birthday Gift", date: viewModel.getCurrentDate(), amount: "200", type: CustomItemType.income.name, category: Category.donation.name, description: "Mom's birthday gift for me ")
        
    }
    
    private func checkDataIfExists(dummyUsername:String) -> Bool {
        var isExist:Bool = false
        for username in usernames {
            if username == dummyUsername {
                isExist = true
                break
            } else {
                isExist = false
            }
        }
        return isExist
    }
   
}

