
//  wetrade
//
//  Created by Kazim Walji on 12/21/20.
//

import UIKit
import FirebaseAuth

var backgroundColor = UIColor.init(red: 88/255, green: 206/255, blue: 152/255, alpha: 1)

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    var logo = UIImage(named: "logo")
    var logoView = UIView()
    var emailTextField = UITextField()
    var passwordTextField = UITextField()
    var nameTextField = UITextField()
    var signUpButton = UIButton()
    var signInButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var url = URL(string: "https://ancient-temple-49323.herokuapp.com")!
        var request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else { return }
            guard let data = data, let _ = response else {
                return
                
            }
            algo1 = Double(data)
        }.resume()
        
        url = URL(string: "https://ancient-temple-49323.herokuapp.com/last")!
        request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else { return }
            guard let data = data, let _ = response else {
                return
                
            }
            algo2 = Double(data)
        }.resume()
        
        let defaultEmail = UserDefaults.standard.string(forKey: "email")
        let defaultPassword = UserDefaults.standard.string(forKey: "password")
        
        if (defaultEmail != nil &&  defaultPassword != nil) {
            Auth.auth().signIn(withEmail: defaultEmail!, password: defaultPassword!) { [self] authResult, error in
                if(error == nil)
                {
                    self.present(TabBarViewController(), animated: true, completion: nil)
                }
            }
        }
        
        view.addSubview(signInButton)
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.setTitleColor(UIColor.white, for: .normal)
        signInButton.setTitle("Already have an account? Sign In", for: .normal)
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
        signInButton.addTarget(self, action: #selector(signIn), for: .touchUpInside)
        
        view.addSubview(signUpButton)
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.setTitleColor(UIColor.white, for: .normal)
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        signUpButton.backgroundColor = .clear
        signUpButton.layer.cornerRadius = 10
        signUpButton.layer.borderWidth = 3
        signUpButton.layer.borderColor = UIColor.white.cgColor
        signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        signUpButton.bottomAnchor.constraint(equalTo: signInButton.topAnchor, constant: -30).isActive = true
        signUpButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        signUpButton.widthAnchor.constraint(equalTo: signInButton.widthAnchor).isActive = true
        signUpButton.addTarget(self, action: #selector(signUp), for: .touchUpInside)
        
        nameTextField.textColor = UIColor.gray
        nameTextField.backgroundColor = backgroundColor
        nameTextField.borderStyle = UITextField.BorderStyle.none
        nameTextField.placeholder = "Enter your name"
        nameTextField.font = UIFont.boldSystemFont(ofSize: 25)
        nameTextField.autocapitalizationType = .none
        nameTextField.autocorrectionType = .no
        nameTextField.textContentType = .oneTimeCode
        nameTextField.borderStyle = UITextField.BorderStyle.roundedRect
        nameTextField.autocorrectionType = UITextAutocorrectionType.no
        nameTextField.keyboardType = UIKeyboardType.default
        nameTextField.returnKeyType = UIReturnKeyType.done
        nameTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        view.addSubview(nameTextField)
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        nameTextField.bottomAnchor.constraint(equalTo: signUpButton.topAnchor, constant: -30).isActive = true
        nameTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        nameTextField.borderStyle = UITextField.BorderStyle.none
        
        passwordTextField.textColor = UIColor.gray
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
        passwordTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        passwordTextField.isSecureTextEntry = true
        view.addSubview(passwordTextField)
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        passwordTextField.bottomAnchor.constraint(equalTo: nameTextField.topAnchor, constant: -45).isActive = true
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
        emailTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        emailTextField.keyboardType = .emailAddress
        view.addSubview(emailTextField)
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        emailTextField.bottomAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: -45).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        emailTextField.borderStyle = UITextField.BorderStyle.none
        
        logoView.alpha = 0
        logoView = UIImageView(image: logo)
        view.addSubview(logoView)
        logoView.translatesAutoresizingMaskIntoConstraints = false
        logoView.bottomAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: -60).isActive = true
        logoView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification,object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification,object: nil)
        
        emailTextField.delegate = self
        nameTextField.delegate = self
        passwordTextField.delegate = self
        
        self.view.backgroundColor = backgroundColor
        
    }
    override func viewDidLayoutSubviews() {
        let nameBottomLine = CALayer()
        nameBottomLine.frame = CGRect(x: 0.0, y: nameTextField.frame.height + 10, width: nameTextField.frame.width, height: 2.0)
        nameBottomLine.backgroundColor = UIColor.white.cgColor
        nameTextField.layer.addSublayer(nameBottomLine)
        
        let passwordBottomLine = CALayer()
        passwordBottomLine.frame = CGRect(x: 0.0, y: passwordTextField.frame.height + 10, width: passwordTextField.frame.width, height: 2.0)
        passwordBottomLine.backgroundColor = UIColor.white.cgColor
        passwordTextField.layer.addSublayer(passwordBottomLine)
        
        let emailBottomLine = CALayer()
        emailBottomLine.frame = CGRect(x: 0.0, y: emailTextField.frame.height + 10, width: emailTextField.frame.width, height: 2.0)
        emailBottomLine.backgroundColor = UIColor.white.cgColor
        emailTextField.layer.addSublayer(emailBottomLine)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    @objc func keyboardWillShow(sender: NSNotification) {
        self.view.frame.origin.y = -150
    }
    
    @objc func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y = 0
    }
    @objc func signUp(sender: UIButton!)
    {
        if(emailTextField.text != nil && passwordTextField.text != nil)
        {
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { authResult, error in
                if error == nil {
                    Auth.auth().signIn(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!)
                    cash = 1000000
                    ref.setValue(["cash": cash ?? 0, "name":self.nameTextField.text!, "portfolio":[Double(cash), Double(cash)]])
                    self.present(TabBarViewController(), animated: true, completion: nil)
                    UserDefaults.standard.setValue(self.emailTextField.text!, forKey: "email")
                    UserDefaults.standard.setValue(self.passwordTextField.text!, forKey: "password")
                } else {
                    let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    self.show(alert, sender: true)
                }
            }
        }
    }
    
    @objc func signIn(sender: UIButton!)
    {
        self.present(Login(), animated: true, completion: nil)
    }
}
extension Numeric {
    init<D: DataProtocol>(_ data: D) {
        var value: Self = .zero
        let size = withUnsafeMutableBytes(of: &value, { data.copyBytes(to: $0)} )
        assert(size == MemoryLayout.size(ofValue: value))
        self = value
    }
}
