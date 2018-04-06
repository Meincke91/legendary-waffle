//
//  InterfaceController.swift
//  Stress-Reducer WatchKit Extension
//
//  Created by Martin Meincke on 04/04/2018.
//  Copyright © 2018 Martin Meincke. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    
    //MARK: Properties
    @IBOutlet var stressLevelLabel: WKInterfaceLabel!
    @IBOutlet var stressLevelPicker: WKInterfacePicker!
    var stressScaleItems: Array<WKPickerItem>?
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        stressScaleItems = (1...5).map {
            let item = WKPickerItem()
            item.title = "\($0)"
            return item
        }
        
        stressLevelPicker.setItems(stressScaleItems)
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
