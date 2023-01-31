//
//  CikisVc.swift
//  Emlak2
//
//  Created by tolgahan sonmez on 26.01.2023.
//


import UIKit
import Firebase

class CikisVc: UIViewController {

    let seconds = 1.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds){
            self.clearCurrentUserData()
            DispatchQueue.main.asyncAfter(deadline: .now() + self.seconds) {
                self.performSegue(withIdentifier: "toLogin", sender: nil)
            }
        }

    }
    


    func clearCurrentUserData(){
        let dbClear = Firestore.firestore()
        dbClear.collection("currentUser").document("currentUserData").delete() { errorClear in
            if errorClear != nil {
                print("Mevcut kullanıcı silinemedi. HATA!")
            } else {
                print("Mevcut kullanıcı silme başarılı.")
            }
        }
        
        let dbClearAuth = Auth.auth()
        do {
            try dbClearAuth.signOut()
            print("Admin çıkışı başarılı")
        } catch {
            print("Auth kullanıcısı çıkış yapamadı.")
        }
    }

}
