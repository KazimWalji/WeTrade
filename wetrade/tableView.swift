//
//  tableView.swift
//  wetrade
//
//  Created by Kazim Walji on 12/23/20.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import Charts
let ref = Database.database().reference().child("Users").child(Auth.auth().currentUser!.uid)
class tableView: UIViewController, UITableViewDelegate, UITableViewDataSource, UITabBarDelegate {
    private let headerId = "headerId"
    private let footerId = "footerId"
    private let cellId = "cellId"
    lazy var tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        tv.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 120, right: 0);
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = .lightGray
        tv.delegate = self
        tv.dataSource = self
        tv.register(customCellTableViewCell.self, forCellReuseIdentifier: self.cellId)
        tv.backgroundColor = backgroundColor
        tv.allowsSelection = false
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "TableView Demo"
        view.addSubview(tableView)
        setupAutoLayout()
        getData()
        self.title = "Home"
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.backgroundColor = backgroundColor
        tableView.cellForRow(at: indexPath)?.selectedBackgroundView?.backgroundColor = backgroundColor
        tableView.cellForRow(at: indexPath)?.isSelected = false
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 15
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellId) as! customCellTableViewCell
        cell.awakeFromNib()
        cell.backgroundColor = backgroundColor
        cell.mainView.backgroundColor = .white
        cell.contentView.backgroundColor = backgroundColor
        cell.addData(index: indexPath.row)
        cell.investButton.tag = indexPath.row
        cell.algoLabel.text = "Algorithm " + String(indexPath.row + 1)
        if indexPath.row == 0 {
            var first = arrays.array1.first
            var last = arrays.array1.last
            var text = (last!.roundToPlaces(places: 3) - first!.roundToPlaces(places: 3)) / first!.roundToPlaces(places: 3)
            text = text.roundToPlaces(places: 3)
            if text < 0 {
                cell.line.colors = [NSUIColor(cgColor: (UIColor.red.cgColor))]
                cell.percentLabel.textColor = .red
            } else {
                cell.percentLabel.textColor = backgroundColor
            }
            let textLabel = String(String(text)) + "%"
            cell.percentLabel.text = textLabel
        } else {
            var first = arrays.array2.first
            var last = arrays.array2.last
            var text = (last!.roundToPlaces(places: 3) - first!.roundToPlaces(places: 3)) / first!.roundToPlaces(places: 3)
            text = text.roundToPlaces(places: 3)
            if text < 0 {
                cell.line.colors = [NSUIColor(cgColor: (UIColor.red.cgColor))]
                cell.percentLabel.textColor = .red
            } else {
                cell.percentLabel.textColor = backgroundColor
            }
            let textLabel = String(String(text)) + "%"
            cell.percentLabel.text = textLabel
        }
        return cell
        
    }
    
    func setupAutoLayout() {
        tableView.backgroundColor = backgroundColor
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func getData() {
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            if let user = User(snapshot: snapshot) {
                cash = user.money
            }
        })
    }
}

