import FirebaseDatabase

class User {
    
    var name:String
    var money:Double
    var al1Purchases: [[String:Double]]
    var al2Purchases: [[String:Double]]
    var portfolio: [Double]
    
    init?(snapshot: DataSnapshot) {
        let empty: [[String:Double]] = []
        guard
            let mon = snapshot.childSnapshot(forPath: "cash").value as? Double,
            let nam = snapshot.childSnapshot(forPath: "name").value as? String,
            let p =  snapshot.childSnapshot(forPath: "portfolio").value as? [Double]
        else { return nil }
        self.money = mon
        self.name = nam
        self.al1Purchases = (snapshot.childSnapshot(forPath: "algo1Purchases").value as? [[String:Double]]) ?? empty
        self.al2Purchases = snapshot.childSnapshot(forPath: "algo2Purchases").value as? [[String:Double]] ?? empty
        self.portfolio = p
    }
    
}

