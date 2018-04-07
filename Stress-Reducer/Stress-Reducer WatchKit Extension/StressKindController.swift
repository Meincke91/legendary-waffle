//
//  StressKindController.swift
//  Stress-Reducer WatchKit Extension
//
//  Created by Esben Kruse on 06/04/2018.
//  Copyright © 2018 Martin Meincke. All rights reserved.
//

import WatchKit
import Foundation


class StressKindController: WKInterfaceController {
    
    //MARK: Properties
    let kindsOfStress = ["High workload", "Fear of failure", "Making choices", "Missing structure", "Social problems", "Pressure", "Other"]
    var selectedKinds: Array<Bool>?
    var defaultColor: UIColor?
    @IBOutlet var table: WKInterfaceTable!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        selectedKinds = []
        loadKindsOfStress()
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        selectedKinds![rowIndex] = !selectedKinds![rowIndex]
        
        let row = table.rowController(at: rowIndex) as! StressKindRowController
        if (selectedKinds![rowIndex]) {
            row.group.setBackgroundColor(UIColor .green)
        } else {
            row.group.setBackgroundColor(UIColor (red: (34/255.0), green: (34/255.0), blue: (35/255.0), alpha: 1.0))
        }
    }
    
    func loadKindsOfStress() {
        table.setNumberOfRows(kindsOfStress.count, withRowType: "StressKindRowController")
        
        for (index, kind) in kindsOfStress.enumerated() {
            let row = table.rowController(at: index) as! StressKindRowController
            row.label.setText(kind)
            selectedKinds?.append(false)
        }
    }
    
}
