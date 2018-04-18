//
//  StressLevelController.swift
//  Stress-Reducer WatchKit Extension
//
//  Created by Martin Meincke on 04/04/2018.
//  Copyright © 2018 Martin Meincke. All rights reserved.
//

import WatchKit
import Foundation
import Alamofire


class StressLevelController: WKInterfaceController {
    
    //MARK: Properties
    @IBOutlet var stressLevelTitel: WKInterfaceLabel!
    @IBOutlet var picker: WKInterfacePicker!
    var pickerItems: Array<WKPickerItem>?
    var selectedItem = 1
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        pickerItems = (1...5).map {
            let item = WKPickerItem()
            item.title = "\($0)"
            return item
        }
        
        picker.setItems(pickerItems)
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func saveToDB() {
        let firebaseUrl = "https://stress-reducer.firebaseio.com/userObservations.json"
        
        let now = Date()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        let dateString = formatter.string(from: now)
        
        let parameters: Parameters = [
            "level": "\(selectedItem)",
            "timestamp": "\(dateString)"
        ]
        
        // Post data to firebase database
        Alamofire.request(firebaseUrl, method: .post, parameters: parameters, encoding: JSONEncoding.default)
    }
    
    //MARK: Actions
    @IBAction func setStressLevel(_ value: Int) {
        // Save selected value
        selectedItem = value + 1
    }
    
    @IBAction func didNext() {
        if (selectedItem < 3) {
            saveToDB()
            presentController(withName: "SuccessController", context: [])
        } else {
            presentController(withName: "StressKindController", context: selectedItem)
        }
    }
}
