//
//  customCellTableViewCell.swift
//  wetrade
//
//  Created by Kazim Walji on 12/23/20.
//

import UIKit
import Charts

class customCellTableViewCell: UITableViewCell {
    
    var mainView = UIView()
    var graph = LineChartView()
    var graphData: [ChartDataEntry] = []
    var line = LineChartDataSet()
    var percentLabel = UILabel()
    var algoLabel = UILabel()
    var investButton = UIButton()
    var sellButton = UIButton()
    var timer = Timer()
    var purchases1: [[String:Double]] = []
    var purchases2: [[String:Double]] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = backgroundColor
        mainView.backgroundColor = backgroundColor
        mainView.layer.cornerRadius = 20
        contentView.addSubview(mainView)
        mainView.translatesAutoresizingMaskIntoConstraints = false
        mainView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        mainView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        mainView.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        mainView.heightAnchor.constraint(equalTo: contentView.heightAnchor, constant: -20).isActive = true
        
        if arrays.array1.count < 2 {
            arrays.array1.append(algo1)
            arrays.array1.append(algo2)
        }
        if  arrays.array2.count < 2 {
            arrays.array2.append(algo1)
            arrays.array2.append(algo2)
        }
        
        algoLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 20)
        algoLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(algoLabel)
        algoLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30).isActive = true
        algoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30).isActive = true
        algoLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 10).isActive = true
        algoLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        graph.isUserInteractionEnabled = false
        graph.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(graph)
        graph.translatesAutoresizingMaskIntoConstraints = false
        graph.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        graph.topAnchor.constraint(equalTo: algoLabel.bottomAnchor, constant: 0).isActive = true
        graph.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30).isActive = true
        graph.leadingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30).isActive = true
        graph.heightAnchor.constraint(equalTo: contentView.heightAnchor, constant: -120).isActive = true
        graph.leftAxis.enabled = false
        graph.rightAxis.enabled = false
        graph.xAxis.enabled = false
        graph.legend.enabled = false
        graph.backgroundColor = .white
        
        percentLabel.translatesAutoresizingMaskIntoConstraints = false
        graph.addSubview(percentLabel)
        percentLabel.trailingAnchor.constraint(equalTo: graph.trailingAnchor, constant: 20).isActive = true
        percentLabel.widthAnchor.constraint(equalToConstant: 80).isActive = true
        percentLabel.bottomAnchor.constraint(equalTo: graph.bottomAnchor, constant: 50).isActive = true
        percentLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        contentView.addSubview(investButton)
        investButton.translatesAutoresizingMaskIntoConstraints = false
        investButton.setTitleColor(UIColor.white, for: .normal)
        investButton.setTitle("Invest", for: .normal)
        investButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        investButton.backgroundColor = UIColor.init(red: 88/255, green: 206/255, blue: 152/255, alpha: 1)
        investButton.layer.cornerRadius = 10
        investButton.leadingAnchor.constraint(equalTo: graph.leadingAnchor).isActive = true
        investButton.bottomAnchor.constraint(equalTo: graph.bottomAnchor, constant: 40).isActive = true
        investButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        investButton.trailingAnchor.constraint(equalTo: graph.centerXAnchor, constant: 0).isActive = true
        investButton.addTarget(self, action: #selector(invested), for: .touchUpInside)
        
        contentView.addSubview(sellButton)
        sellButton.translatesAutoresizingMaskIntoConstraints = false
        sellButton.setTitleColor(UIColor.white, for: .normal)
        sellButton.setTitle("Sell", for: .normal)
        sellButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        sellButton.backgroundColor = .systemRed
        sellButton.layer.cornerRadius = 10
        sellButton.leadingAnchor.constraint(equalTo: investButton.trailingAnchor, constant: 15).isActive = true
        sellButton.bottomAnchor.constraint(equalTo: graph.bottomAnchor, constant: 40).isActive = true
        sellButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        sellButton.trailingAnchor.constraint(equalTo: percentLabel.leadingAnchor, constant: -15).isActive = true
        sellButton.addTarget(self, action: #selector(sell), for: .touchUpInside)
        
        line = LineChartDataSet(entries: graphData, label: "HII")
        
        if #available(iOS 14.0, *) {
            self.backgroundConfiguration = .none
        } else {
            self.selectedBackgroundView = nil
            self.isSelected = false
        }
        self.isUserInteractionEnabled = true
        timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(getAlgos), userInfo: nil, repeats: true)
    }
    
    @objc func sell(sender: UIButton!) {
        ref.observeSingleEvent(of: .value, with: { [weak self] (snapshot) in
            if let user = User(snapshot: snapshot) {
                cash = user.money
                if self?.tableView?.indexPath(for: self!)?.row == 0 {
                    if user.al1Purchases.count > 0{
                        var totalA1 = 0.0
                        for purchase in user.al1Purchases {
                            let p = (algo1 - purchase["price"]!)/purchase["price"]!
                            totalA1 += purchase["amount"]!*p
                            totalA1 += purchase["amount"]!
                        }
                        cash = (totalA1+cash).rounded()
                        ref.child("cash").setValue(cash)
                        ref.child("algo1Purchases").setValue([[String:Double]]())
                        let alert = UIAlertController(title: "Congrats!", message: "You sold an algorithm!", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                        UIApplication.shared.windows.first!.rootViewController?.show(alert, sender: true)
                    } else {
                        let alert = UIAlertController(title: "Sorry!", message: "You haven't invested in this algorithm yet!", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                        UIApplication.shared.windows.first!.rootViewController?.show(alert, sender: true)
                    }
                } else if user.al2Purchases.count > 0 {
                    var totalA2 = 0.0
                    for purchase in user.al2Purchases {
                        let p = (algo2 - purchase["price"]!)/purchase["price"]!
                        totalA2 += purchase["amount"]!*p
                        totalA2 += purchase["amount"]!
                    }
                    cash = (totalA2+cash).rounded()
                    ref.child("cash").setValue(cash)
                    ref.child("algo2Purchases").setValue([[String:Double]]())
                    let alert = UIAlertController(title: "Congrats!", message: "You sold an algorithm!", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    UIApplication.shared.windows.first!.rootViewController?.show(alert, sender: true)
                } else {
                    let alert = UIAlertController(title: "Sorry!", message: "You haven't invested in this algorithm yet!", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    UIApplication.shared.windows.first!.rootViewController?.show(alert, sender: true)
                }
            }
            
        })
    }
    @objc func invested(sender: UIButton!) {
        getCash()
        let alert = UIAlertController(title: ("Algorthm " + String((self.tableView?.indexPath(for: self)?.row)! + 1)), message: "Enter the amount of cash", preferredStyle: .alert)
        alert.addTextField(configurationHandler: { (textField) -> Void in
            textField.keyboardType = .numberPad
        })
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists
            let number = Double(textField?.text ?? "0.0") ?? 0.0
            if number > 0.0 && number <= cash {
                if self.tableView?.indexPath(for: self)?.row == 0 {
                    self.purchases1.append(["price":algo1!, "amount":number])
                    cash = cash - number
                    ref.child("cash").setValue(cash)
                    ref.child("algo1Purchases").setValue(self.purchases1)
                } else {
                    self.purchases2.append(["price": algo2, "amount":number])
                    cash = cash - number
                    ref.child("cash").setValue(cash)
                    ref.child("algo2Purchases").setValue(self.purchases2)
                }
            } else {
                let alert = UIAlertController(title: "Sorry!", message: "You don't have enough cash for that purchase.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                UIApplication.shared.windows.first!.rootViewController?.show(alert, sender: true)
            }
        }))
        
        UIApplication.shared.windows.first!.rootViewController?.show(alert, sender: true)
    }
    func getCash() {
        ref.observeSingleEvent(of: .value, with: { [weak self] (snapshot) in
            
            if let user = User(snapshot: snapshot) {
                
                cash = user.money
                if user.al1Purchases.count > 0 {
                    self?.purchases1 = user.al1Purchases
                }
                if (user.al2Purchases.count > 0) {
                    self?.purchases2 = user.al2Purchases
                }
            }
            
        })
    }
    
    @objc func getAlgos() {
        self.tableView?.reloadData()
        var url = URL(string: "https://ancient-temple-49323.herokuapp.com")!
        var request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else { return }
            guard let data = data, let _ = response else {
                return
                
            }
            algo1 = Double(data)
            if algo1 != arrays.array1.last {
                arrays.array1.append(algo1)
            }
        }.resume()
        
        url = URL(string: "https://ancient-temple-49323.herokuapp.com/last")!
        request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else { return }
            guard let data = data, let _ = response else {
                return
                
            }
            
            algo2 = Double(data)
            if algo2 != arrays.array2.last {
                arrays.array2.append(algo2)
            }
        }.resume()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.layoutSubviews()
    }
    internal static func dequeue() {
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }
    
    func addData(index: Int) {
        var dataPoints: [Double] = []
        graphData = []
        if index == 0 {
            dataPoints = arrays.array1
        } else if index == 1 {
            dataPoints = arrays.array2
        }
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(x: Double(i), y: Double(dataPoints[i]))
            graphData.append(dataEntry)
        }
        graphData.sort(by: { $0.x < $1.x })
        line = LineChartDataSet(entries: self.graphData, label: "HII")
        line.drawCirclesEnabled = false
        line.lineWidth = 3
        line.colors = [NSUIColor(cgColor: (backgroundColor?.cgColor)!)]
        let data = LineChartData()
        data.removeDataSetByIndex(0)
        data.addDataSet(line)
        data.setDrawValues(false)
        self.graph.data = data
    }
    
}

extension Double {
    mutating func roundToPlaces(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
extension UITableViewCell {
    var tableView: UITableView? {
        var view = superview
        while let v = view, v.isKind(of: UITableView.self) == false {
            view = v.superview
        }
        return view as? UITableView
    }
}

struct arrays {
    static var array1:[Double] = []
    static var array2:[Double] = []
}
