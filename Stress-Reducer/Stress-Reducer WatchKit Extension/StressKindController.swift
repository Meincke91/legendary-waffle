//
//  StressKindController.swift
//  Stress-Reducer WatchKit Extension
//
//  Created by Esben Kruse on 06/04/2018.
//  Copyright © 2018 Martin Meincke. All rights reserved.
//

import WatchKit
import Foundation
import Alamofire


class StressKindController: WKInterfaceController {
    
    //MARK: Properties
    var kindsOfStress = ["High workload",
                         "Fear of failure",
                         "Making choices",
                         "Missing structure",
                         "Social problems",
                         "Pressure",
                         "Other"]
    var selectedKinds: Array<Bool>?
    var selectedLevel: Int?
    let defaultLabelColor = UIColor (red: (34/255.0), green: (34/255.0), blue: (35/255.0), alpha: 1.0)
    var locationManager: CLLocationManager = CLLocationManager()
    var mapLocation: CLLocationCoordinate2D?
    
    @IBOutlet var table: WKInterfaceTable!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        selectedLevel = context as? Int
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
            row.group.setBackgroundColor(defaultLabelColor)
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
    
    func findSelectedKinds() -> [String] {
        var kinds: [String] = []
    
        for (index, selected) in (selectedKinds?.enumerated())! {
            if (selected) {
                kinds.append(kindsOfStress[index])
            }
        }
    
        return kinds
    }
    
    func saveToDB() {
        let firebaseUrl = "https://stress-reducer.firebaseio.com/userObservations.json"
        let finalKinds = findSelectedKinds()
        
        let now = Date()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        let dateString = formatter.string(from: now)
        
        let parameters: Parameters = [
            "level": "\(selectedLevel ?? 1)",
            "type": finalKinds,
            "timestamp": "\(dateString)"
        ]
        
        // Post data to firebase database
        Alamofire.request(firebaseUrl, method: .post, parameters: parameters, encoding: JSONEncoding.default)
    }
    
    //MARK: Actions
    @IBAction func didSave() {
        // Save data to database.
        saveToDB()
        presentController(withName: "SuccessController", context: [])
    }
}
