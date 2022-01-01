//
//  ViewController.swift
//  Local Notification
//
//  Created by cemal tüysüz on 28.12.2021.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextField: UITextField!
    @IBOutlet weak var eventDatePicker: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventDatePicker.datePickerMode = .date
        eventDatePicker.preferredDatePickerStyle = .wheels
        
        // İzin kontrolü
        let notifyCenter = UNUserNotificationCenter.current()
        notifyCenter.requestAuthorization(options: [.alert, .sound]){
            (granted,error) in
            if granted {
                print("Permission Granted !")
            }else {
                print("Permission Denied !")
            }
        }
    }

    @IBAction func notifyButton(_ sender: Any) {
        let content = UNMutableNotificationContent()
        
        if let t = titleTextField.text, let d = contentTextField.text {
            // Create Content
            content.title = t
            content.body = d
            
            // Create Trigger
            var selectedDateComponents = Calendar.current.dateComponents([.day, .year, .month], from: eventDatePicker.date)
            
            selectedDateComponents.hour = 16
            selectedDateComponents.minute = 50
            selectedDateComponents.second = 0
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: selectedDateComponents, repeats: false)
            
            // Create Request
            let uuidString = UUID().uuidString
            
            let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
            
            // Send Request
            UNUserNotificationCenter.current().add(request){ (errorr) in
                print((String(describing: errorr?.localizedDescription)))
            }
        }
        
    }
}

