//
//  SpendWiseAppUITests.swift
//  SpendWiseAppUITests
//
//  Created by Quan Tran on 19/9/19.
//  Copyright © 2019 Quan Tran. All rights reserved.
//

import XCTest

class SpendWiseAppUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    // Do run below functions in order (or test will fail as some are dependent on others for their child elements to appear)
    func testUnsuccessfulLogin(){
        let app = XCUIApplication()
        let invalidUsername:String = "InvalidUsername"
        let invalidPassword:String = "InvalidPassword"
        
        let usernameTextField = app.textFields["username"]
        let passwordTextField = app.secureTextFields["password"]
        let loginButton = app.buttons["login"]
        // TODO:
        // (1) Check what happens if user press login without entering any credentials
        // Flow: Leave username and password empty and press 'login' button
        // Result: The app should return an alert asking for the missing credentials
        // ______________________________________________________________________________-
        // wait for animation to finish
        sleep(3)
        
        loginButton.tap()
        app.alerts["Missing credentials"].buttons["Ok"].tap()
        
        // (2) Check what happens if user enters wrong username (not in database) or wrong password
        // Flow: Intentionally enter a wrong username and password and press 'login' button
        // Result: The app should return an alert saying either username doesnt exist or wrong password
        usernameTextField.tap()
        usernameTextField.typeText(invalidUsername)
        
        app/*@START_MENU_TOKEN@*/.buttons["Next:"]/*[[".keyboards",".buttons[\"Tiếp\"]",".buttons[\"Next:\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        passwordTextField.typeText(invalidPassword)
        
        app/*@START_MENU_TOKEN@*/.buttons["Done"]/*[[".keyboards",".buttons[\"Xong\"]",".buttons[\"Done\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        loginButton.tap()
        
        app.alerts["Invalid Username"].buttons["Ok"].tap()
    }
    
    func testSuccessfulLogin(){
        let app = XCUIApplication()
        let validUsername:String = "ValidUsername"
        let validPassword:String = "ValidPassword"
        
        let usernameTextField = app.textFields["username"]
        let passwordTextField = app.secureTextFields["password"]
        let loginButton = app.buttons["login"]
        
        // TODO:
        // (1) Check what happens if user enters correct credentials
        // Flow: Enter correct username and password empty and press 'login' button
        // Result: The app should prompt user to go into the app
        // *NOTE* A dummy account is created to test this function solely, if you choose to change the above validUsername and validPassword into other strings, then testSuccessfulSignup() must be run first in order for this to prompt you to go inside the app
        // ______________________________________________________________________________-
        // wait for animation to finish
        sleep(3)
        
        usernameTextField.tap()
        usernameTextField.typeText(validUsername)
        
        app/*@START_MENU_TOKEN@*/.buttons["Next:"]/*[[".keyboards",".buttons[\"Tiếp\"]",".buttons[\"Next:\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        passwordTextField.typeText(validPassword)
        
        app/*@START_MENU_TOKEN@*/.buttons["Done"]/*[[".keyboards",".buttons[\"Xong\"]",".buttons[\"Done\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        loginButton.tap()
    }
    
    
    func testSignup(){
        let app = XCUIApplication()
        let validName:String = "ValidName"
        let validUsername:String = "ValidUsername1" //   wish to test a second time, please increment the number '1' so you can bypass the error ' This username is already exist ' in Signup screen 1 (e.g "ValidUsername2") or just delete the app
        let validPassword:String = "ValidPassword"
       
        
        // Signup screen 1 UI elements
        let signupButton = app.buttons["signup"]
        let nameTextField = app.textFields["signup_name"]
        let usernameTextField = app.textFields["signup_username"]
        let passwordTextField = app.secureTextFields["signup_password"]
        let confirmPasswordTextField = app.secureTextFields["signup_confirmpassword"]
        let continueButton1 = app.buttons["signup_continue1"]
        // Signup screen 2 UI elements
        let firstPinTextField = app.secureTextFields["signup_pin1"]
        let secondPinTextField = app.secureTextFields["signup_pin2"]
        let thirdPinTextField = app.secureTextFields["signup_pin3"]
        let fourthPinTextField = app.secureTextFields["signup_pin4"]
        let continueButton2 = app.buttons["signup_continue2"]
        // Signup screen 3 UI elements
        let doneButton = app.buttons["signup_done"]
        let beginButton = app.buttons["signup_begin"]
        // Login Screen ui elements
       
        
        // *BIG NOTE* To test all errors in signup screens(total 3 screens), the app will enter wrong information first to show the errors then correct information later for further testing and lastly, successfully signup. We only test a specific error, not all of them.
        // (e.g: wrong regex only but not regex and number of texts and empty at the same time)
        
        // TODO:
        // (1) Signup Screen 1:
        // Flow: Leave name, username, password, confirmPassword empty and press 'Continue' then re-enter correct information then press 'Continue' again to see differences
        // Result: For entering wrong part, the app should display 'empty' errors immediately and an alert if user presses the 'Continue' button. After entering correct information, the app should prompt user to Signup Screen 2 to test more errors.
        //
        // ______________________________________________________________________________-
        // wait for animation to finish
        sleep(3)
        
        
        signupButton.tap()
        // Signup Screen 1 starts:
        // leaving everything empty
        continueButton1.tap()
        app.alerts["Invalid Form"].buttons["Ok"].tap()
        // begin entering correct information
        nameTextField.tap()
        nameTextField.typeText(validName)
        
        usernameTextField.tap()
        usernameTextField.typeText(validUsername)
        
        app/*@START_MENU_TOKEN@*/.buttons["Next:"]/*[[".keyboards",".buttons[\"Tiếp\"]",".buttons[\"Next:\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        passwordTextField.typeText(validPassword)
        
        app.buttons["Next:"].tap()
        confirmPasswordTextField.typeText(validPassword)
        
        app/*@START_MENU_TOKEN@*/.buttons["Done"]/*[[".keyboards.buttons[\"Done\"]",".buttons[\"Done\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        continueButton1.tap()
        // TODO:
        // (2) Signup Screen 2:
        // Flow: Leave all 4 PINs empty and press 'Continue' then re-enter correct information and press 'Continue' button again to see differences
        // Result: An alert is displayed if user presses the 'Continue' button but not yet filled the Pins. After entering the PINs, the app should prompt user to Signup Screen 3 to test more errors.
        //
        // Signup Screen 2 starts:
        sleep(1)
        // tapping out to hide keyboard
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 1).children(matching: .other).element.tap()
        
        // leaving pin numbers empty
        continueButton2.tap()
        app.alerts["Invalid Pin Number"].buttons["Ok"].tap()
        // begin entering correct information
        firstPinTextField.tap()
        firstPinTextField.typeText("0")
        secondPinTextField.typeText("0")
        thirdPinTextField.typeText("0")
        fourthPinTextField.typeText("0")
        
        continueButton2.tap()
        // TODO:
        // (2) Signup Screen 3:
        // Flow: Press 'Done' immediately. After that, press 'Begin' button to access camera and go back to signup screen through 'Done' bar button and here, users have successfully added facial id, click the 'Done' button again to see differences.
        // Result: An alert is displayed as users have yet to successfully created a facial ID. After going back from CameraScreen and hit 'Done' button, the account is recorded into CoreData and users are prompted back to LoginScreen to sign in.
        //
        // Signup Screen 3 starts:
        sleep(1)
        doneButton.tap()
        app.alerts[" No Facial Recognition"].buttons["Ok"].tap()
        
        beginButton.tap()
        // Here, facial recognition feature is yet added so by pressing done back, assuming the face id is added
        sleep(1)
        app.navigationBars["Title"].buttons["Done"].tap()
        sleep(1)
        doneButton.tap()
        
        // End
    }
    
    func testForgotPassword(){
        // Test errors first then enter correct information later (same as signup)
      
        let app = XCUIApplication()
        let validUsername:String = "ValidUsername1" //   wish to test a second time, please increment the number '1' so you can prompt to next screen as this account is already signed up
        let newPassword:String = "ValidPassword1"
        
        let forgotPasswordButton = app.buttons["forgotpassword"]
        // ForgotPassword screen 1 UI elements
        let usernameTextField = app.textFields["forgotpassword_username"]
        let checkButton = app.buttons["forgotpassword_check"]
        // ForgotPassword screen 2 UI elements
        let firstPinTextField = app.secureTextFields["forgotpassword_pin1"]
        let secondPinTextField = app.secureTextFields["forgotpassword_pin2"]
        let thirdPinTextField = app.secureTextFields["forgotpassword_pin3"]
        let fourthPinTextField = app.secureTextFields["forgotpassword_pin4"]
        let continueButton = app.buttons["forgotpassword_continue"]
        // ForgotPassword screen 3 UI elements
        let newPasswordTextField = app.secureTextFields["forgotpassword_newpassword"]
        let confirmNewPasswordTextField = app.secureTextFields["forgotpassword_confirmnewpassword"]
        let doneButton = app.buttons["forgotpassword_done"]
        
        // TODO:
        // (1) ForgotPassword Screen 1:
        // Flow: Leave username empty and press 'Check' then re-enter correct information then press 'Check' again to see differences
        // Result: For entering wrong part, the app should display 'empty' error immediately and an alert if user presses the 'Check' button. After entering correct information, the app should prompt user to ForgotPassword Screen 2 to test more errors.
        //
        // ______________________________________________________________________________-
        // wait for animation to finish
        sleep(3)
        
        forgotPasswordButton.tap()
        // ForgotPassword Screen 1 starts
        checkButton.tap()
        app.alerts["Missing Username"].buttons["Ok"].tap()
        
        usernameTextField.tap()
        usernameTextField.typeText(validUsername)
        app/*@START_MENU_TOKEN@*/.buttons["Done"]/*[[".keyboards.buttons[\"Done\"]",".buttons[\"Done\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        checkButton.tap()
        
        // (1) ForgotPassword Screen 2:
        // Flow: Leave all 4 PINs empty and press 'Continue' then re-enter correct information then press 'Continue' again to see differences
        // Result: For entering wrong part, the app should display 'empty' error immediately and an alert if user presses the 'Continue' button. After entering correct information, the app should prompt user to ForgotPassword Screen 3 to test more errors.
        //
        sleep(1)
        // ForgotPassword Screen 2 starts
        // tapping outside to hide keyboard
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 2).children(matching: .other).element.children(matching: .other).element(boundBy: 0).children(matching: .other).element(boundBy: 2).tap()
        // leaving 4 pins empty and press continue
        continueButton.tap()
        app.alerts["Invalid Pin Number"].buttons["Ok"].tap()
        // entering correct information
        
        firstPinTextField.tap()
        firstPinTextField.typeText("0")
        secondPinTextField.typeText("0")
        thirdPinTextField.typeText("0")
        fourthPinTextField.typeText("0")
        
        continueButton.tap()
        
        // (1) ForgotPassword Screen 3:
        // Flow: Leave both textfields empty and press 'Done' then re-enter correct information then press 'Done' again to see differences
        // Result: For entering wrong part, the app should display 'empty' error immediately and an alert if user presses the 'Done' button. After entering correct information, the app should prompt user back to Login Screen to login.
        //
        sleep(1)
        // ForgotPassword Screen 3 starts
        // leaving both textfields empty
        doneButton.tap()
        app.alerts["Invalid Form"].buttons["Ok"].tap()
        
        // entering correct information
        newPasswordTextField.tap()
        newPasswordTextField.typeText(newPassword)
        
        confirmNewPasswordTextField.tap()
        confirmNewPasswordTextField.typeText(newPassword)
        
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 2).children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element(boundBy: 0).children(matching: .other).element(boundBy: 2).tap()
        
        doneButton.tap()
        
    }
    
//    func testAddItem(){
//
//    }
//
//    func testDeleteItem(){
//
//    }
//
//    func testEditItem(){
//
//    }
//
//    func testGoalSetter(){
//
//    }
//
//    func testCurrencyConverter(){
//
//    }

}
