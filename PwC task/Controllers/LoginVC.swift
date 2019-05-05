//
//  LoginVC.swift
//  PwC task
//
//  Created by Christian Hjelmslund on 03/05/2019.
//  Copyright © 2019 Christian Hjelmslund. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var backToLogin: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var underline3TopConstraint: NSLayoutConstraint!
    @IBOutlet weak var signUpButtonTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var underline3: UIView!
    @IBOutlet weak var underline2: UIView!
    @IBOutlet weak var underline1: UIView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var loginView: UIView!
    private var signUpPressedFirstTime = false
    private var api = PwCEventAPI()
    private var signUpButtonOriginalConstraint:CGFloat = 0
    @IBOutlet weak var firstNameTextField: UITextField!{
        didSet {
            firstNameTextField.tintColor = .white
            firstNameTextField.setIcon(#imageLiteral(resourceName: "firstname"))
        }
    }
    @IBOutlet weak var lastNameTextField: UITextField!{
        didSet {
            lastNameTextField.tintColor = .white
            lastNameTextField.setIcon(#imageLiteral(resourceName: "firstname"))
        }
    }
    @IBOutlet weak var phoneTextField: UITextField!{
        didSet {
            phoneTextField.tintColor = .white
            phoneTextField.setIcon(#imageLiteral(resourceName: "phone"))
        }
    }
    @IBOutlet weak var passwordTextField: UITextField! {
        didSet {
            passwordTextField.tintColor = .white
            passwordTextField.setIcon(#imageLiteral(resourceName: "lock"))
        }
    }
    @IBOutlet weak var emailTextField: UITextField! {
        didSet {
            emailTextField.tintColor = .white
            emailTextField.setIcon(#imageLiteral(resourceName: "user"))
        }
    }
    @IBOutlet weak var messageLabel: UILabel!
    private var email: String?
    private var password: String?
    private var firstname: String?
    private var lastname: String?
    private var phone: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        signUpButtonOriginalConstraint = signUpButtonTopConstraint.constant
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        phoneTextField.delegate = self
    }
    
    
    @IBAction func tapped(_ sender: Any) {
        view.endEditing(true)
    }
    
    func setupUI(){
        navigationController?.navigationBar.barStyle = .black
        titleLabel.textColor = .white
        titleLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        backToLogin.setDarkGradient()
        messageLabel.textColor = .error
        self.view.setGradientBackground()
        loginButton.fancyButton()
        signUpForm(shouldShow: false)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
   
    @IBAction func firstNameAction(_ sender: UITextField) {
        firstname = sender.text
    }
    @IBAction func lastNameAction(_ sender: UITextField) {
        lastname = sender.text
    }
    
    @IBAction func phoneAction(_ sender: UITextField) {
        phone = sender.text
    }
    
    @IBAction func passwordAction(_ sender: UITextField) {
        password = sender.text
    }
    
    @IBAction func emailAction(_ sender: UITextField) {
        email = sender.text
    }
    
    func updateMessage(message: String){
        messageLabel.text = message
        messageLabel.shake()
    }
    
    @IBAction func login(_ sender: Any) {
        guard let email = email else {
            updateMessage(message: "email cannot be empty.")
            return }
        guard let password = password else {
            updateMessage(message: "password cannot be empty.")
            return }
        Auth.auth().signIn(withEmail: email, password: password) { user, error in
            if error != nil {
                self.updateMessage(message: (error?.localizedDescription)!)
            } else {
               self.performSegue(withIdentifier: "goToMain", sender: nil)
            }
        }
    }
    
    @IBAction func backToLoginAction(_ sender: Any) {
        signUpForm(shouldShow: false)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func signUpForm(shouldShow: Bool) {
        if shouldShow {
            updateMessage(message: "")
            backToLogin.isHidden = false
            firstNameTextField.isHidden = false
            lastNameTextField.isHidden = false
            phoneTextField.isHidden = false
            underline1.isHidden = false
            underline2.isHidden = false
            underline3.isHidden = false
            loginButton.isHidden = true
            signUpPressedFirstTime = true
            signUpButtonTopConstraint.constant = underline3TopConstraint.constant + 50 + underline3.frame.height + signUpButton.frame.height
        } else {
            updateMessage(message: "")
            signUpButtonTopConstraint.constant = signUpButtonOriginalConstraint
            backToLogin.isHidden = true
            loginButton.isHidden = false
            firstNameTextField.isHidden = true
            lastNameTextField.isHidden = true
            phoneTextField.isHidden = true
            underline1.isHidden = true
            underline2.isHidden = true
            underline3.isHidden = true
            signUpPressedFirstTime = false
        }
    }
    
    
    @IBAction func signUp(_ sender: Any) {
        if !signUpPressedFirstTime {
            signUpForm(shouldShow: true)
            signUpPressedFirstTime = true
        } else {
            guard let email = email else {
                updateMessage(message: "please provide an email.")
                return }
            guard let password = password else {
                updateMessage(message: "please provide a password.")
                return }
            guard let firstname = firstname else {
                updateMessage(message: "please provide a first name.")
                return }
            guard let lastname = lastname else {
                updateMessage(message: "please provide a last name.")
                return }
            guard let phone = phone else {
                updateMessage(message: "please provide a last phone.")
                return }
            api.createUser(email: email, password: password, firstname: firstname, lastname: lastname, phone: phone) { status, _description in
                switch status {
                case .SUCCESS:
                    self.performSegue(withIdentifier: "goToMain", sender: nil)
                case .FAILURE:
                    self.updateMessage(message: _description)
                }
            }
        }
    }
}
