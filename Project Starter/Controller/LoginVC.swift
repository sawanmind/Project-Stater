//
//  LoginVC.swift
//  Project Starter
//
//  Created by iOS Developer on 1/3/18.
//  Copyright © 2018 sawanmind. All rights reserved.
//

import UIKit


class LoginVC: UIViewController , UITextFieldDelegate{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.shared.statusBarView?.isHidden = true
        hideKeyboardWhenTappedAround()
        view.backgroundColor = UIColor.darkTheme()
        setupConstraints()
        
    }
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = true
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var usernameTextField: UITextField = {
        let view = UITextField()
        view.backgroundColor = UIColor.textFieldColor()
        view.layer.cornerRadius = 5
        view.autocorrectionType = .no
        view.layer.masksToBounds = true
        view.placeholder = "Username"
        view.textColor = UIColor.white
        view.tintColor = UIColor.white
        view.placeHolderColor = UIColor.placeholderColor()
        view.setLeftPaddingPoints(10)
        view.setRightPaddingPoints(10)
        view.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var passwordTextField: UITextField = {
        let view = UITextField()
        view.backgroundColor = UIColor.textFieldColor()
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        view.placeholder = "Password"
        view.textColor = UIColor.white
        view.tintColor = UIColor.white
        view.placeHolderColor = UIColor.placeholderColor()
        view.autocorrectionType = .no
        view.isSecureTextEntry = true
        view.setLeftPaddingPoints(10)
        view.setRightPaddingPoints(10)
        view.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var signInButton: UIButton = {
        let view = UIButton(type: .system)
        view.backgroundColor = UIColor.textFieldColor()
        view.layer.cornerRadius = 5
        view.layer.borderColor = UIColor.textFieldColor().cgColor
        view.layer.borderWidth = 2
        view.layer.masksToBounds = true
        view.setTitle("SIGN IN", for: .normal)
        view.setTitleColor(UIColor.white, for: .normal)
        view.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.semibold)
        view.isEnabled = false
        view.addTarget(self, action: #selector(self.handleLogin), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private func setupConstraints(){
        view.addSubview(containerView)
        containerView.addSubview(usernameTextField)
        containerView.addSubview(passwordTextField)
        containerView.addSubview(signInButton)
        
        
        containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        containerView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 160).isActive = true
        
        usernameTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        usernameTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        usernameTextField.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        usernameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        passwordTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor,constant:5).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        signInButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        signInButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        signInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor,constant:5).isActive = true
        signInButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    
    @objc private  func handleLogin(){
        
        hideKeyboardWhenTappedAround()
        guard  let username = usernameTextField.text, !username.isEmpty,
            let password = passwordTextField.text, !password.isEmpty
            else {
            showStatusAlert(withImage: UIImage(named:"error"), title: "Error", message: "Enter username & password.")
                return }
        
        UserDefaults.saveUserMobileNumber(MobileNumber: usernameTextField.text! + passwordTextField.text!)
        
        showStatusAlert(withImage: UIImage(named:"Success icon"), title: nil, message: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            UIApplication.shared.keyWindow?.rootViewController = TabBarVC()
        }
        
        
    }
    
}


extension LoginVC {
    @objc  func editingChanged(_ textField: UITextField) {
        if textField.text?.count == 1 {
            if textField.text?.first == " " {
                textField.text = ""
                return
            }
        }
        guard
            let username = usernameTextField.text, !username.isEmpty,
            let password = passwordTextField.text, !password.isEmpty

            else  {
                signInButton.setTitleColor(UIColor.white, for: .normal)
                signInButton.backgroundColor = UIColor.textFieldColor()
                signInButton.layer.borderColor = UIColor.textFieldColor().cgColor
                self.signInButton.isEnabled = false
                return
        }
        textField.returnKeyType = .next
        signInButton.setTitleColor(UIColor.white, for: .normal)
        signInButton.backgroundColor = UIColor.orange
        signInButton.layer.borderColor = UIColor.orange.cgColor
        signInButton.isEnabled = true
       
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.hideKeyboardWhenTappedAround()
        return  true
    }
    
}


