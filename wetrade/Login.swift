//
//  ViewController.swift
//  wetrade
//
//  Created by Kazim Walji on 12/21/20.
//

import UIKit
import FirebaseAuth

class Login: UIViewController, UITextFieldDelegate {
    
    var logo = UIImage(named: "logo")
    var logoView = UIView()
    var emailTextField = UITextField()
    var passwordTextField = UITextField()
    var signUpButton = UIButton()
    var signInButton = UIButton()
    var backgroundColor = UIColor.init(red: 88/255, green: 206/255, blue: 152/255, alpha: 1)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(signInButton)
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.setTitleColor(UIColor.white, for: .normal)
        signInButton.setTitle("New User? Sign up here", for: .normal)
        signInButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        signInButton.backgroundColor = .clear
        signInButton.layer.cornerRadius = 10
        signInButton.layer.borderWidth = 0
        signInButton.layer.borderColor = UIColor.white.cgColor
        signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        signInButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60).isActive = true
        signInButton.heightAnchor.constraint(equalToConstant: 15).isActive = true
        signInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        signInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        signInButton.addTarget(self, action: #selector(signUp), for: .touchUpInside)
        
        view.addSubview(signUpButton)
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.setTitleColor(UIColor.white, for: .normal)
        signUpButton.setTitle("Sign In", for: .normal)
        signUpButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        signUpButton.backgroundColor = .clear
        signUpButton.layer.cornerRadius = 10
        signUpButton.layer.borderWidth = 3
        signUpButton.layer.borderColor = UIColor.white.cgColor
        signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        signUpButton.bottomAnchor.constraint(equalTo: signInButton.topAnchor, constant: -30).isActive = true
        signUpButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        signUpButton.widthAnchor.constraint(equalTo: signInButton.widthAnchor).isActive = true
        signUpButton.addTarget(self, action: #selector(signIn), for: .touchUpInside)
        
        passwordTextField.textColor = UIColor.gray
        passwordTextField.isSecureTextEntry = true
        passwordTextField.backgroundColor = backgroundColor
        passwordTextField.borderStyle = UITextField.BorderStyle.none
        passwordTextField.placeholder = "Enter your passsword"
        passwordTextField.font = UIFont.boldSystemFont(ofSize: 25)
        passwordTextField.autocapitalizationType = .none
        passwordTextField.autocorrectionType = .no
        passwordTextField.textContentType = .oneTimeCode
        passwordTextField.borderStyle = UITextField.BorderStyle.roundedRect
        passwordTextField.autocorrectionType = UITextAutocorrectionType.no
        passwordTextField.keyboardType = UIKeyboardType.default
        passwordTextField.returnKeyType = UIReturnKeyType.done
        passwordTextField.clearButtonMode = UITextField.ViewMode.whileEditing;
        view.addSubview(passwordTextField)
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        passwordTextField.centerYAnchor.constraint(equalTo: signUpButton.topAnchor, constant: -60).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        passwordTextField.borderStyle = UITextField.BorderStyle.none
        
        emailTextField.textColor = UIColor.gray
        emailTextField.placeholder = "Enter your email adress"
        emailTextField.font = UIFont.boldSystemFont(ofSize: 25)
        emailTextField.autocapitalizationType = .none
        emailTextField.autocorrectionType = .no
        emailTextField.textContentType = .oneTimeCode
        emailTextField.borderStyle = UITextField.BorderStyle.roundedRect
        emailTextField.autocorrectionType = UITextAutocorrectionType.no
        emailTextField.keyboardType = UIKeyboardType.default
        emailTextField.returnKeyType = UIReturnKeyType.done
        emailTextField.clearButtonMode = UITextField.ViewMode.whileEditing;
        emailTextField.keyboardType = .emailAddress
        view.addSubview(emailTextField)
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        emailTextField.centerYAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: -60).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        emailTextField.borderStyle = UITextField.BorderStyle.none
        
        logoView = UIImageView(image: logo)
        view.addSubview(logoView)
        logoView.translatesAutoresizingMaskIntoConstraints = false
        logoView.centerYAnchor.constraint(equalTo: emailTextField.topAnchor, constant: -120).isActive = true
        logoView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.view.backgroundColor = backgroundColor
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil);
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    @objc func keyboardWillShow(sender: NSNotification) {
        self.view.frame.origin.y = -150 // Move view 150 points upward
    }
    
    @objc func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y = 0 // Move view to original position
    }
    
    override func viewDidLayoutSubviews() {
        let passwordBottomLine = CALayer()
        passwordBottomLine.frame = CGRect(x: 0.0, y: passwordTextField.frame.height + 10, width: passwordTextField.frame.width, height: 2.0)
        passwordBottomLine.backgroundColor = UIColor.white.cgColor
        passwordTextField.layer.addSublayer(passwordBottomLine)
        
        let emailBottomLine = CALayer()
        emailBottomLine.frame = CGRect(x: 0.0, y: emailTextField.frame.height + 10, width: emailTextField.frame.width, height: 2.0)
        emailBottomLine.backgroundColor = UIColor.white.cgColor
        emailTextField.layer.addSublayer(emailBottomLine)
    }
    @objc func signIn(sender: UIButton!)
    {
        if(emailTextField.text != nil && passwordTextField.text != nil)
        {
            Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { [self] authResult, error in
                if(error != nil)
                {
                    let alert = UIAlertController(title: "Incorrect Information", message: "We didn't recognize that email or password.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    self.show(alert, sender: true)
                }
                else
                {
                    self.present(TabBarViewController(), animated: true, completion: nil)
                    UserDefaults.standard.setValue(emailTextField.text!, forKey: "email")
                    UserDefaults.standard.setValue(passwordTextField.text!, forKey: "password")
                }
            }
        }
    }
    
    @objc func signUp(sender: UIButton!)
    {
        self.present(SignUpViewController(), animated: true, completion: nil)
    }
}
