//
//  StressLevelController.swift
//  Stress-Reducer WatchKit Extension
//
//  Created by Martin Meincke on 04/04/2018.
//  Copyright © 2018 Martin Meincke. All rights reserved.
//

import WatchKit
import Foundation


class StressLevelController: WKInterfaceController {
    
    //MARK: Properties
    @IBOutlet var stressLevelTitel: WKInterfaceLabel!
    @IBOutlet var picker: WKInterfacePicker!
    var pickerItems: Array<WKPickerItem>?
    
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
    
    //MARK: Actions
    @IBAction func setStressLevel(_ value: Int) {
        //Save selected value
    }
}
