//
//  ViewController.swift
//  MyClock
//
//  Created by Beatriz Castro on 23/04/21.
//

import UIKit


class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var pickerSeconds: UIPickerView!
    
    var pickerData: [String] = ["10 segundos",
                                "20 segundos",
                                "30 segundos",
                                "40 segundos",
                                "50 segundos",
                                "60 segundos"]
    
    @IBOutlet weak var text_timer: UILabel!
    @IBOutlet weak var btn_start_timer: UIButton!
    
    var selected_time = 10
    var timer: Timer!
    
    @IBOutlet weak var clock_image: UIImageView!
    
    @IBOutlet weak var clock_view: UIView!
    
    let center = UNUserNotificationCenter.current()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerSeconds.delegate = self
        pickerSeconds.dataSource = self

    }
    
    override func didReceiveMemoryWarning() {
           super.didReceiveMemoryWarning()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    
    @IBAction func start_timer(_ sender: Any) {
        pickerSeconds.isHidden = !pickerSeconds.isHidden
        text_timer.isHidden = !text_timer.isHidden
        
        
        
        if(!text_timer.isHidden){
            
            btn_start_timer.setTitle("Cancelar", for: .normal)
            
            askPermissionNotification()
            selected_time = Int(pickerData[pickerSeconds.selectedRow(inComponent: 0)].prefix(2))!
            text_timer.text = String(selected_time)
           
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(runTimer), userInfo: nil, repeats: true)
            
            scheduleNotification(id: 1, timeInterval: Double(selected_time), title: "Alarme", body: "O seu alarme tocou!")
            
            
        }else {
            btn_start_timer.setTitle("Começar", for: .normal)
            removeNotification(id: 1)
            timer.invalidate()
        }
        
        
    }
    
    @objc func runTimer(timer: Timer) {
        if (selected_time > 1) {
            selected_time -= 1
            text_timer.text = String(selected_time)
        } else {
            text_timer.text = String(0)
            playAnimationClock()
            timer.invalidate()
        }
    }
    
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if UIDevice.current.orientation.isLandscape {
            clock_image.image = UIImage(named: "relogio_digital")
        } else {
            clock_image.image = UIImage(named: "relogio_analogico")
        }
        
    }
    
    func askPermissionNotification(){
        center.requestAuthorization(options: [.alert, .sound]) { granted, error in
            if granted {
                print("Temos permissão")
            } else {
                print("Permissão negada")
            }
        }
    }
    
    func scheduleNotification(id: Int, timeInterval: TimeInterval, title: String, body: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
        let request = UNNotificationRequest(
            identifier: "\(id)",
            content: content,
            trigger: trigger)
        center.add(request)
    }
    
    func removeNotification(id: Int) {
      center.removePendingNotificationRequests(withIdentifiers: ["\(id)"])
    }
    
    func playAnimationClock(){
        let animation = CAKeyframeAnimation()
        animation.keyPath = "position.x"
        animation.values = [0, 10, -10, 10, -5, 5, -5, 0 ]
        animation.keyTimes = [0, 0.125, 0.25, 0.375, 0.5, 0.625, 0.75, 0.875, 1]
        animation.duration = 0.4
        animation.isAdditive = true

        clock_view.layer.add(animation, forKey: "shake")
    }
   
}

