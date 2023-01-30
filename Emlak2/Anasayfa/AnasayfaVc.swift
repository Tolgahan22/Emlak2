//
//  AnasayfaVc.swift
//  Emlak2
//
//  Created by tolgahan sonmez on 27.01.2023.
//

import UIKit
import Firebase


class AnasayfaVc: UIViewController, UITableViewDelegate, UITableViewDataSource {


    
    @IBOutlet weak var curUserText: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    var userDict = [String : String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        curUserText.text = ""
        getCurrentUser()
        tableView.delegate = self
        tableView.dataSource = self
    
    }
    
    
    //TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "anacell", for: indexPath) as! AnasayfaCell
        cell.aciklaText.text = "merhaba dünyalı merkez akçayda"
        cell.fiyatText.text = "1600000"
        cell.odaText.text = "3+1"
        cell.semtText.text = "Sarıkız"
        
        
        return cell
    }
    

    func getCurrentUser(){
        let seconds = 1.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            
            let db = Firestore.firestore()
            db.collection("currentUser").addSnapshotListener { currentSnapshot, currentError in
                if currentError != nil {
                    print(currentError?.localizedDescription ?? "Error")
                } else {
                    if currentSnapshot?.isEmpty != true{
                        for cur in currentSnapshot!.documents{
                            if let curId = cur.get("currentUser") as? String{
                                
                                db.collection("Users").addSnapshotListener { userSnapshot, userError in
                                    if userError != nil {
                                        print("USer listesi çekilemedi.")
                                    } else {
                                        if userSnapshot?.isEmpty != true {
                                            for ii in userSnapshot!.documents {
                                                let userId = ii.get("userMail") as? String
                                                let userName = ii.get("userName")
                                                self.userDict[curId] = userName! as! String
                                            }
                                            self.curUserText.textColor = UIColor.black
                                            self.curUserText.text = self.userDict[curId]
                                        }
                                    }
                                }
                            }
                        }
                    } else {
                        self.curUserText.textColor = UIColor.red
                        self.curUserText.text = "Admin"
                    }
                }
            }
        }
    }


}


