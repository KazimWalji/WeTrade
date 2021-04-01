//
//  sliders.swift
//  wetrade
//
//  Created by Kazim Walji on 12/22/20.
//

import UIKit
import SafariServices
var algo1: Double!
class sliders: UIViewController {
    
    var riskLabel = UILabel()
    var firstSlider = UISlider()
    var secondSlider = UISlider()
    var lowRisk = UILabel()
    var highRisk = UILabel()
    
    var returnRate = UILabel()
    var returnsFast = UILabel()
    var returnSlow = UILabel()
    
    var continueButton = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = backgroundColor
        
        
        view.addSubview(continueButton)
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        continueButton.setTitleColor(UIColor.white, for: .normal)
        continueButton.setTitle("Continue", for: .normal)
        continueButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        continueButton.backgroundColor = .clear
        continueButton.layer.cornerRadius = 10
        continueButton.layer.borderWidth = 3
        continueButton.layer.borderColor = UIColor.white.cgColor
        continueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        continueButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        continueButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        continueButton.addTarget(self, action: #selector(continuePressed), for: .touchUpInside)
        
        
        view.addSubview(secondSlider)
        secondSlider.translatesAutoresizingMaskIntoConstraints = false
        secondSlider.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        secondSlider.centerYAnchor.constraint(equalTo: continueButton.topAnchor, constant: -80).isActive = true
        secondSlider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 65).isActive = true
        secondSlider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -65).isActive = true
        secondSlider.heightAnchor.constraint(equalToConstant: 5).isActive = true
        
        returnSlow.textAlignment = .center
        returnSlow.text = "Slow"
        returnSlow.font = UIFont.boldSystemFont(ofSize: 20)
        returnSlow.textColor = .white
        view.addSubview(returnSlow)
        returnSlow.translatesAutoresizingMaskIntoConstraints = false
        returnSlow.centerXAnchor.constraint(equalTo: secondSlider.leadingAnchor, constant: 0).isActive = true
        returnSlow.topAnchor.constraint(equalTo: secondSlider.bottomAnchor, constant: 20).isActive = true
        returnSlow.heightAnchor.constraint(equalToConstant: 30).isActive = true
        returnSlow.widthAnchor.constraint(equalToConstant: 75).isActive = true
        
        returnsFast.textAlignment = .center
        returnsFast.text = "Fast"
        returnsFast.font = UIFont.boldSystemFont(ofSize: 20)
        returnsFast.textColor = .white
        view.addSubview(returnsFast)
        returnsFast.translatesAutoresizingMaskIntoConstraints = false
        returnsFast.centerXAnchor.constraint(equalTo: secondSlider.trailingAnchor, constant: 0).isActive = true
        returnsFast.topAnchor.constraint(equalTo: secondSlider.bottomAnchor, constant: 20).isActive = true
        returnsFast.heightAnchor.constraint(equalToConstant: 30).isActive = true
        returnsFast.widthAnchor.constraint(equalToConstant: 75).isActive = true
        
        returnRate = UILabel()
        returnRate.textAlignment = .center
        returnRate.text = "When do you want to see significant returns?"
        returnRate.font = UIFont.boldSystemFont(ofSize: 25)
        returnRate.textColor = .white
        returnRate.numberOfLines = 2
        view.addSubview(returnRate)
        returnRate.translatesAutoresizingMaskIntoConstraints = false
        returnRate.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        returnRate.bottomAnchor.constraint(equalTo: secondSlider.topAnchor, constant: -60).isActive = true
        returnRate.heightAnchor.constraint(equalToConstant: 85).isActive = true
        returnRate.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        view.addSubview(firstSlider)
        firstSlider.translatesAutoresizingMaskIntoConstraints = false
        firstSlider.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        firstSlider.bottomAnchor.constraint(equalTo: returnRate.topAnchor, constant: -80).isActive = true
        firstSlider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 65).isActive = true
        firstSlider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -65).isActive = true
        firstSlider.heightAnchor.constraint(equalToConstant: 5).isActive = true
        
        lowRisk.textAlignment = .center
        lowRisk.text = "Low Risk"
        lowRisk.font = UIFont.boldSystemFont(ofSize: 20)
        lowRisk.textColor = .white
        view.addSubview(lowRisk)
        lowRisk.translatesAutoresizingMaskIntoConstraints = false
        lowRisk.centerXAnchor.constraint(equalTo: firstSlider.leadingAnchor, constant: 0).isActive = true
        lowRisk.topAnchor.constraint(equalTo: firstSlider.bottomAnchor, constant: 20).isActive = true
        lowRisk.heightAnchor.constraint(equalToConstant: 30).isActive = true
        lowRisk.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        
        highRisk.textAlignment = .center
        highRisk.text = "High Risk"
        highRisk.font = UIFont.boldSystemFont(ofSize: 20)
        highRisk.textColor = .white
        view.addSubview(highRisk)
        highRisk.translatesAutoresizingMaskIntoConstraints = false
        highRisk.centerXAnchor.constraint(equalTo: secondSlider.trailingAnchor, constant: 0).isActive = true
        highRisk.topAnchor.constraint(equalTo: firstSlider.bottomAnchor, constant: 20).isActive = true
        highRisk.heightAnchor.constraint(equalToConstant: 30).isActive = true
        highRisk.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        
        riskLabel.textAlignment = .center
        riskLabel.text = "What is your level of risk?"
        riskLabel.font = UIFont.boldSystemFont(ofSize: 25)
        riskLabel.textColor = .white
        view.addSubview(riskLabel)
        riskLabel.translatesAutoresizingMaskIntoConstraints = false
        riskLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        riskLabel.bottomAnchor.constraint(equalTo: firstSlider.topAnchor, constant: -60).isActive = true
        riskLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        riskLabel.widthAnchor.constraint(equalToConstant: 500).isActive = true
        
        
        
        
    }
    
    @objc func continuePressed(sender: UIButton!)
    {
        print("Continue")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "table") as! tableView
        self.present(vc, animated: true)
    }
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
}
