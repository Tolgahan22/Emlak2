//
//  ViewController.swift
//  Emlak2
//
//  Created by tolgahan sonmez on 26.01.2023.
//


import UIKit
import Firebase
import FirebaseCore

class ViewController: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passText: UITextField!
    
    var newDict = [String : String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserList()

    }

    func getUserList () {
        let seconds = 1.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            let db = Firestore.firestore()
            db.collection("Users").addSnapshotListener { [self] snapShot, errorSnapshot in
                if errorSnapshot != nil {
                    print(errorSnapshot?.localizedDescription ?? "Hata")
                } else {
                    if snapShot?.isEmpty != true {
                        for i in snapShot!.documents{
                            let userId = i.get("userMail") as? String
                            let passId = i.get("userPass") as? String
                            newDict[userId!] = passId!
                        }
                    }
                    print(newDict)
                }
            }
        }
    }


    @IBAction func loginButton(_ sender: Any) {

        if emailText.text != "" && passText.text != "" {
            Auth.auth().signIn(withEmail: emailText.text!, password: passText.text!) { authDataLogin, errorLogin in
                if errorLogin != nil {
                    print(errorLogin?.localizedDescription ?? "Hata")
                    if self.newDict.index(forKey: self.emailText.text!) != nil {
                        if self.newDict[self.emailText.text!] == self.passText.text! {
                            self.performSegue(withIdentifier: "toApp", sender: nil)
                            print("Kullanıcı girişi başarılı")
                            // Mevcut kullanıcıyı listeye ekleme
                            let dbCurAdd = Firestore.firestore()
                            let dbCurAddArray = ["currentUser" : self.emailText.text!] as [String : Any]
                            dbCurAdd.collection("currentUser").document("currentUserData").setData(dbCurAddArray) { curAddError in
                                if curAddError != nil {
                                    print(curAddError?.localizedDescription ?? "Hata")
                                } else {
                                    print("Mevcut kullanıcı Firebase ' a güncellendi.")
                                }
                            }
                            // İlk bölümün sonu
                        } else {
                            self.makeAlert(title: "Hata", message: "Yanlış Şifre")
                        }
                    } else {
                        self.makeAlert(title: "Hata", message: "Yanlış kullanıcı adı")
                    }
                } else {
                    self.performSegue(withIdentifier: "toApp", sender: nil)
                    print("Admin girişi başarılı")
                }
            }
        } else {
            self.makeAlert(title: "Hata", message: "Boşlukları doldur.")
        }
        
    }
    
    

    
    
    
    func makeAlert(title:String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
    
}


