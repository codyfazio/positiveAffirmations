//
//  LoginController.swift
//  PosAff
//
//  Created by Cody Fazio on 4/18/17.
//  Copyright © 2017 Cody Fazio. All rights reserved.
//

import UIKit
import Firebase

class LoginController: UIViewController {
    
    let inputsContainerView : UIView = {
        let container = UIView()
        container.backgroundColor = .white
        container.translatesAutoresizingMaskIntoConstraints = false
        container.layer.cornerRadius = 5
        container.layer.masksToBounds = true
        return container
    }()
    
    lazy var loginRegisterButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.blue.withAlphaComponent(0.8)
        button.setTitle("Register", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        
        button.addTarget(self, action: #selector(handleUserRegistry), for: .touchUpInside)
        return button
    }()
    
    let nameTextField: UITextField = {
        
        let field = UITextField()
        field.placeholder = "Name"
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
        
    }()
    
    let emailTextField: UITextField = {
        
        let field = UITextField()
        field.placeholder = "Email"
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
        
    }()
    
    let passwordTextField: UITextField = {
        
        let field = UITextField()
        field.placeholder = "Password"
        field.isSecureTextEntry = true
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
        
    }()
    
    let nameSeparatorView: UIView = {
        
        let separator = UIView()
        separator.backgroundColor = .lightGray
        separator.translatesAutoresizingMaskIntoConstraints = false
        return separator
    }()
    
    let emailSeparatorView: UIView = {
        
        let separator = UIView()
        separator.backgroundColor = .lightGray
        separator.translatesAutoresizingMaskIntoConstraints = false
        return separator
    }()
    
    let appIconImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .red
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var loginRegisterSegmentedControl: UISegmentedControl = {
        
        let control = UISegmentedControl(items: ["Login", "Register"])
        control.tintColor = .white
        control.selectedSegmentIndex = 1
        control.translatesAutoresizingMaskIntoConstraints = false
        control.addTarget(self, action: #selector(handleLoginRegisterSelection), for: .valueChanged)
    
        return control
    }()

    var inputsContainerViewHeightAnchor: NSLayoutConstraint?
    var nameTextFieldHeightAnchor: NSLayoutConstraint?
    var emailTextFieldHeightAnchor: NSLayoutConstraint?
    var passwordTextFieldHeightAnchor: NSLayoutConstraint?

    override func viewDidLoad() {
        super.viewDidLoad()

        addGradient(startColor: UIColor.blue, endColor: UIColor.green)
        view.addSubview(appIconImageView)
        view.addSubview(inputsContainerView)
        view.addSubview(loginRegisterButton)
        view.addSubview(loginRegisterSegmentedControl)
        
        configureInputsContainerView()
        configureLoginRegisterButton()
        configureAppIconImageView()
        configureLoginRegisterSegmentedControl()
    }
    
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: Helper Methods
    func addGradient(startColor: UIColor, endColor: UIColor){
        
        let gradient:CAGradientLayer = CAGradientLayer()
        gradient.frame.size = self.view.frame.size
        gradient.colors = [startColor.cgColor, endColor.cgColor]
        
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        self.view.layer.addSublayer(gradient)
    }
    
    func configureInputsContainerView() {
        //x,y,w,h
        inputsContainerView.centerXAnchor.constraint(equalTo:view.centerXAnchor).isActive = true
        inputsContainerView.centerYAnchor.constraint(equalTo:view.centerYAnchor).isActive = true
        inputsContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        inputsContainerViewHeightAnchor = inputsContainerView.heightAnchor.constraint(equalToConstant: 150)
        inputsContainerViewHeightAnchor?.isActive = true
        
        inputsContainerView.addSubview(nameTextField)
        inputsContainerView.addSubview(nameSeparatorView)
        inputsContainerView.addSubview(emailTextField)
        inputsContainerView.addSubview(emailSeparatorView)
        inputsContainerView.addSubview(passwordTextField)
        
        //x,y,w,h
        nameTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        nameTextField.topAnchor.constraint(equalTo:inputsContainerView.topAnchor).isActive = true
        nameTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        nameTextFieldHeightAnchor = nameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
        nameTextFieldHeightAnchor?.isActive = true

        //x,y,w,h
        nameSeparatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        nameSeparatorView.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        nameSeparatorView.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        nameSeparatorView.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
        
        //x,y,w,h
        emailTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        emailTextField.topAnchor.constraint(equalTo:nameTextField.bottomAnchor).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        emailTextFieldHeightAnchor = emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
        emailTextFieldHeightAnchor?.isActive = true

        //x,y,w,h
        emailSeparatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        emailSeparatorView.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        emailSeparatorView.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        emailSeparatorView.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
        
        //x,y,w,h
        passwordTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        passwordTextField.topAnchor.constraint(equalTo:emailTextField.bottomAnchor).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        passwordTextFieldHeightAnchor = passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
        passwordTextFieldHeightAnchor?.isActive = true
    }
    
    func configureLoginRegisterButton() {
        //x,y,w,h
        loginRegisterButton.centerXAnchor.constraint(equalTo:view.centerXAnchor).isActive = true
        loginRegisterButton.topAnchor.constraint(equalTo:inputsContainerView.bottomAnchor, constant: 12).isActive = true
        loginRegisterButton.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        loginRegisterButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func configureAppIconImageView() {
        //x,y,w,h
        appIconImageView.centerXAnchor.constraint(equalTo:view.centerXAnchor).isActive = true
        appIconImageView.bottomAnchor.constraint(equalTo:loginRegisterSegmentedControl.topAnchor, constant: -12).isActive = true
        appIconImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        appIconImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    func configureLoginRegisterSegmentedControl() {
        //x,y,w,h
        loginRegisterSegmentedControl.centerXAnchor.constraint(equalTo:view.centerXAnchor).isActive = true
        loginRegisterSegmentedControl.bottomAnchor.constraint(equalTo:inputsContainerView.topAnchor, constant: -12).isActive = true
        loginRegisterSegmentedControl.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor, multiplier: 1.0).isActive = true
        loginRegisterSegmentedControl.heightAnchor.constraint(equalToConstant: 36).isActive = true
    }
    
    func handleUserRegistry() {
        guard let nameString = nameTextField.text,
            let emailString = emailTextField.text,
            let passwordString = passwordTextField.text else {
                print("Missing info")
                return
        }
        FIRAuth.auth()?.createUser(withEmail: emailString, password: passwordString) {user, error in
            
            guard error == nil else {
                print(error)
                return
            }
            
            guard let uid = user?.uid else {return}
            
            let reference = FIRDatabase.database().reference(fromURL: "https://positiveaffirmations-914f2.firebaseio.com/")
            let usersReference = reference.child("users").child(uid)
            let values = ["name" : nameString,
                          "email" : emailString]
            usersReference.updateChildValues(values) {error, reference in
                if let creationError = error{
                    print (creationError)
                } else {
                    self.dismiss(animated: true, completion: nil)
                }
            }
        
        }
    }
    
    func handleLoginRegisterSelection() {
        let selectedIndex = loginRegisterSegmentedControl.selectedSegmentIndex
        let buttonTitle = loginRegisterSegmentedControl.titleForSegment(
            at: selectedIndex)
        loginRegisterButton.setTitle(buttonTitle, for: .normal)
        
        //Toggle height of container view and hide nameTextField
        if selectedIndex == 0 {
            inputsContainerViewHeightAnchor?.constant = 100
            nameTextFieldHeightAnchor?.isActive = false
            nameTextFieldHeightAnchor = nameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 0)
            nameTextFieldHeightAnchor?.isActive = true
            nameTextField.isHidden = true
            
            print(nameTextFieldHeightAnchor)
            
            emailTextFieldHeightAnchor?.isActive = false
            emailTextFieldHeightAnchor = emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/2)
            emailTextFieldHeightAnchor?.isActive = true
            
            passwordTextFieldHeightAnchor?.isActive = false
            passwordTextFieldHeightAnchor = passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/2)
            passwordTextFieldHeightAnchor?.isActive = true


        } else {
            inputsContainerViewHeightAnchor?.constant = 150
            nameTextFieldHeightAnchor?.isActive = false
            nameTextFieldHeightAnchor = nameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
            nameTextFieldHeightAnchor?.isActive = true
            nameTextField.isHidden = false

            
            emailTextFieldHeightAnchor?.isActive = false
            emailTextFieldHeightAnchor = emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
            emailTextFieldHeightAnchor?.isActive = true
            
            passwordTextFieldHeightAnchor?.isActive = false
            passwordTextFieldHeightAnchor = passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
            passwordTextFieldHeightAnchor?.isActive = true
        }
    }
}
