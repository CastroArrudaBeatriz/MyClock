//
//  ViewController.swift
//  MyClock
//
//  Created by Beatriz Castro on 23/04/21.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var pickerSeconds: UIPickerView!
    
    var pickerData: [String] = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerSeconds.delegate = self
        pickerSeconds.dataSource = self
        
        pickerData = ["10 segundos",
                      "20 segundos",
                      "30 segundos",
                      "40 segundos",
                      "50 segundos",
                      "60 segundos"]
        

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


}

