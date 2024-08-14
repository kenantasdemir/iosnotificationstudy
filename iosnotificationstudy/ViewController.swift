//
//  ViewController.swift
//  iosnotificationstudy
//
//  Created by kenan on 13.08.2024.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {
    
    var izinKontrol:Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        UNUserNotificationCenter.current().delegate = self
       
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge], completionHandler: { (granted,error) in
            
            self.izinKontrol = granted
            
            if granted {
                print("İzin alma işlemi başarılı")
            }else{
                print("İzin alma işlemi başarısız!!!!")
            }
            
        })
                                                                
    }
    
    
    
    @IBAction func pullDownButton(_ sender: UIButton) {
        sender.isHidden = false
    }
    

    @IBAction func createNotification(_ sender: UIButton) {
        if izinKontrol{
            
            let evet = UNNotificationAction(identifier: "evet", title: "Evet", options: .foreground)
            let hayir = UNNotificationAction(identifier: "hayir", title: "Hayır", options: .foreground)
            let sil = UNNotificationAction(identifier: "sil", title: "Sil", options: .destructive)
            
            let kategori = UNNotificationCategory(identifier: "kat", actions: [evet,hayir,sil], intentIdentifiers: [],  options: [])
            
            UNUserNotificationCenter.current().setNotificationCategories([kategori])
            
            let icerik = UNMutableNotificationContent()
            icerik.title = "HEADING"
            icerik.subtitle = "SUBTITLE"
            icerik.body = "MESSAGE"
            icerik.badge = 2
            icerik.sound = UNNotificationSound.default
            
            icerik.categoryIdentifier = "kat"
            /*
            var date = DateComponents()
            date.minute = 30
            date.hour = 8
            date.day = 20
            date.month = 4
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
            */
            let tetikleme = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
            let bildirimIstek = UNNotificationRequest(identifier: "Bildirim", content: icerik, trigger: tetikleme)
            
            UNUserNotificationCenter.current().add(bildirimIstek,withCompletionHandler: nil)
        }
    }
}
extension ViewController:UNUserNotificationCenterDelegate{
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler([.banner,.sound,.badge])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        if response.actionIdentifier == "evet" {
            print("Doğru Cevap")
        }
        
        if response.actionIdentifier == "hayir" {
            print("Yanlış Cevap")
        }
        
        if response.actionIdentifier == "sil" {
            print("Cevap verilmedi")
        }
        
        completionHandler()
        
    }
}
