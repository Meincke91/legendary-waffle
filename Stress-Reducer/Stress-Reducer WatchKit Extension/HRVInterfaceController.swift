//
//  HRVInterfaceController.swift
//  Stress-Reducer WatchKit Extension
//
//  Created by Esben Kruse on 07/04/2018.
//  Copyright © 2018 Martin Meincke. All rights reserved.
//

import WatchKit
import Foundation


class HRVInterfaceController: WKInterfaceController {

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    override func handleAction(withIdentifier identifier: String?, forRemoteNotification remoteNotification: [AnyHashable : Any]) {
        switch identifier {
        case "describeButtonAction"?:
            WKInterfaceController.reloadRootPageControllers(withNames: ["StressLevelController"], contexts: ["StressLevelController"], orientation: WKPageOrientation .horizontal, pageIndex: 0)
        default:
            break
        }
    }
}
