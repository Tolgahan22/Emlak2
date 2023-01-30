//
//  AnasayfaVc.swift
//  Emlak2
//
//  Created by tolgahan sonmez on 27.01.2023.
//

import UIKit
import Firebase


class AnasayfaVc: UIViewController {

    
    @IBOutlet weak var curUserText: UILabel!
    
    var userDict = [String : String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        curUserText.text = ""
        getCurrentUser()
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

