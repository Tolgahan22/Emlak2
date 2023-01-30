//
//  AdminVc.swift
//  Emlak2
//
//  Created by tolgahan sonmez on 27.01.2023.

import UIKit
import Firebase
import MapKit

class AdminVc: UIViewController, MKMapViewDelegate {


    @IBOutlet weak var getNameText: UITextField!
    
    @IBOutlet weak var getEmailText: UITextField!
    
    @IBOutlet weak var getPassText: UITextField!
    
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.delegate = self

    }
    
    // Map view komutları
    @objc func chooseLocation(gestureRecognizer:UILongPressGestureRecognizer){
        if gestureRecognizer.state == .began {
            let touchedPoint = gestureRecognizer.location(in: self.mapView)
            let touchedCoordinates = self.mapView.convert(touchedPoint, toCoordinateFrom: self.mapView)
            let annotation = MKPointAnnotation()
            annotation.coordinate = touchedCoordinates
            //annotation.title = titleText.text
            //annotation.subtitle = subTitleText.text
            self.mapView.addAnnotation(annotation)
        }
    }
    
    
    
    //Kaydet buton
    @IBAction func newUserAddButton(_ sender: Any) {
        let db = Firestore.firestore()
        let dbArray = ["userMail" : getEmailText.text!, "userPass" : getPassText.text!, "userName": getNameText.text!] as [String : Any]
        if getNameText.text == "" && getPassText.text == "" && getEmailText.text == "" {
            self.makeAlert(title: "Hata", message: "Boşlukları doldur.")
        } else {
            db.collection("Users").addDocument(data: dbArray) { errorUserAdd in
                if errorUserAdd != nil {
                    self.makeAlert(title: "Hata", message: errorUserAdd?.localizedDescription ?? "Hata")
                } else {
                    self.makeAlert(title: "Başarılı", message: "Kullanıcı eklendi")
                }
            }
        }
        getPassText.text = ""
        getNameText.text = ""
        getEmailText.text = ""
    }
    
    func makeAlert(title:String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
    
    
    
    
}
