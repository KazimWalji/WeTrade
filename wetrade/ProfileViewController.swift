//
//  ProfileViewController.swift
//  wetrade
//
//  Created by Kazim Walji on 1/30/21.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import Charts

var cash: Double!
var algo1: Double!
var algo2: Double!

class ProfileViewController: UIViewController, UITabBarDelegate {
    
    var cashLabel = UILabel()
    var logOff = UIButton()
    var reset = UIButton()
    var nameLabel = UILabel()
    var portfolioLabel = UILabel()
    var portfolioData: [Double] = []
    var graph = LineChartView()
    var graphData: [ChartDataEntry] = []
    var timer = Timer()
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        self.view.backgroundColor = backgroundColor
        self.title = "Profile"
        
        cashLabel.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 17)
        cashLabel.translatesAutoresizingMaskIntoConstraints = false
        cashLabel.backgroundColor = .clear
        cashLabel.textColor = .white
        cashLabel.textAlignment = .left
        view.addSubview(cashLabel)
        cashLabel.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 150).isActive = true
        cashLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        cashLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        cashLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        nameLabel.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 30)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.backgroundColor = .clear
        nameLabel.textColor = .white
        nameLabel.textAlignment = .left
        view.addSubview(nameLabel)
        nameLabel.bottomAnchor.constraint(equalTo: cashLabel.topAnchor, constant: 0).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        portfolioLabel.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 17)
        portfolioLabel.translatesAutoresizingMaskIntoConstraints = false
        portfolioLabel.backgroundColor = .clear
        portfolioLabel.textColor = .white
        portfolioLabel.textAlignment = .left
        view.addSubview(portfolioLabel)
        portfolioLabel.topAnchor.constraint(equalTo: cashLabel.bottomAnchor, constant: 0).isActive = true
        portfolioLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        portfolioLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        portfolioLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        reset.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 30)
        reset.translatesAutoresizingMaskIntoConstraints = false
        reset.setTitle("Reset Cash", for: .normal)
        reset.backgroundColor = .white
        reset.setTitleColor(backgroundColor, for: .normal)
        reset.titleLabel?.textAlignment = .center
        reset.layer.cornerRadius = 20
        self.view.addSubview(reset)
        reset.topAnchor.constraint(equalTo: portfolioLabel.bottomAnchor, constant: 15).isActive = true
        reset.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        reset.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        reset.heightAnchor.constraint(equalToConstant: 50).isActive = true
        reset.addTarget(self, action: #selector(resetCash), for: .touchUpInside)
        
        graph.isUserInteractionEnabled = true
        graph.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(graph)
        graph.translatesAutoresizingMaskIntoConstraints = false
        graph.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        graph.topAnchor.constraint(equalTo: reset.bottomAnchor, constant: 15).isActive = true
        graph.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        graph.leadingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        graph.heightAnchor.constraint(equalToConstant: 300).isActive = true
        graph.leftAxis.enabled = true
        graph.rightAxis.enabled = false
        graph.xAxis.enabled = false
        graph.legend.enabled = false
        graph.leftAxis.axisMinimum = 0
        graph.backgroundColor = .clear
        
        logOff.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 30)
        logOff.translatesAutoresizingMaskIntoConstraints = false
        logOff.setTitle("Sign Out", for: .normal)
        logOff.backgroundColor = .white
        logOff.setTitleColor(backgroundColor, for: .normal)
        logOff.titleLabel?.textAlignment = .center
        logOff.layer.cornerRadius = 20
        self.view.addSubview(logOff)
        logOff.topAnchor.constraint(equalTo: graph.bottomAnchor, constant: 15).isActive = true
        logOff.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        logOff.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        logOff.heightAnchor.constraint(equalToConstant: 50).isActive = true
        logOff.addTarget(self, action: #selector(signOut), for: .touchUpInside)
        
        timer = Timer.scheduledTimer(timeInterval: 10.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    @objc func signOut(sender: UIButton!) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        }catch let logOffError as NSError {
            let alert = UIAlertController(title: "Error", message: logOffError as? String, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.show(alert, sender: true)
        }
        UserDefaults.standard.setValue(nil, forKey: "email")
        UserDefaults.standard.setValue(nil, forKey: "password")
        self.present(SignUpViewController(), animated: true, completion: nil)
        
    }
    @objc func timerAction() {
        getData()
    }
    func addData() {
        var array: Array<Int?> = Array(repeating: 0, count: self.portfolioData.count)
        graphData = []
        for i in 0..<portfolioData.count {
            array[i] = Int(portfolioData[i])
        }
        if array.count == 1 {
            array.append(Int(array[0]!))
            portfolioData = [Double(array[0]!), Double(array[1]!)]
        }
        for i in 0..<array.count {
            let dataEntry = ChartDataEntry(x: Double(i), y: Double(array[i]!))
            graphData.append(dataEntry)
        }
        if portfolioData.last! > 10000.0 {
            graph.leftAxis.axisMinimum = (portfolioData.min()! - 1000.0)
        }
        let line = LineChartDataSet(entries: self.graphData, label: "HII")
        line.drawCirclesEnabled = false
        line.lineWidth = 3
        line.colors = [NSUIColor(cgColor: UIColor.black.cgColor)]
        let data = LineChartData()
        data.removeDataSetByIndex(0)
        data.addDataSet(line)
        data.setDrawValues(false)
        self.graph.data = data
    }
    @objc func resetCash(sender: UIButton!) {
        cash = 1000000
        cashLabel.text = "You have $" + String(cash) + " dollars in your account"
        ref.child("cash").setValue(cash)
        ref.child("algo1Purchases").setValue([[String:Double]]())
        ref.child("algo2Purchases").setValue([[String:Double]]())
        ref.child("portfolio").setValue([1000000, 1000000])
        self.graphData = []
        getData()
    }
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item.image ==  UIImage(systemName: "homekit") {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "table") as! tableView
            self.present(vc,
                         animated: false)
        }
    }
    func getData() {
        ref.observeSingleEvent(of: .value, with: { [weak self] (snapshot) in
            if let user = User(snapshot: snapshot) {
                self?.nameLabel.text = user.name
                self?.portfolioData = user.portfolio
                cash = user.money
                var totalA1 = 0.0
                var totalA2 = 0.0
                self?.cashLabel.text = "You have $" + String(cash) + " dollars in your account"
                if algo1 == nil {
                    self?.portfolioLabel.text = "Portfolio data unavailable"
                } else if user.al1Purchases.count > 0 {
                    for purchase in user.al1Purchases {
                        let p = (algo1 - purchase["price"]!)/purchase["price"]!
                        totalA1 += purchase["amount"]!*p
                        totalA1 += purchase["amount"]!
                    }
                }
                if user.al2Purchases.count > 0 {
                    for purchase in user.al2Purchases {
                        let p = (algo2 - purchase["price"]!)/purchase["price"]!
                        totalA2 += purchase["amount"]!*p
                        totalA2 += purchase["amount"]!
                    }
                }
                let portfolioValue = (totalA1+totalA2+cash).rounded()
                self?.portfolioLabel.text = "Your portfolio is worth $" + String(Int(portfolioValue)) + " dollars"
                if portfolioValue != self?.portfolioData.last {
                    self?.portfolioData.append(portfolioValue)
                }
                ref.child("portfolio").setValue(self?.portfolioData)
                self?.addData()
            }
            
        })
    }
}
