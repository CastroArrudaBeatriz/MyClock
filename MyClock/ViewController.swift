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
            
            selected_time = Int(pickerData[pickerSeconds.selectedRow(inComponent: 0)].prefix(2))!
            text_timer.text = String(selected_time)
            
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(runTimer), userInfo: nil, repeats: true)
            
        }else {
            btn_start_timer.setTitle("Começar", for: .normal)
            timer.invalidate()
        }
        
        
    }
    
    @objc func runTimer(timer: Timer) {
        if (selected_time > 1) {
            selected_time -= 1
            text_timer.text = String(selected_time)
        } else {
            text_timer.text = String(0)
            timer.invalidate()
        }
    }

}

