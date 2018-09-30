//
//  InterfaceController.swift
//  Reps WatchKit Extension
//
//  Created by Peter Olsen on 9/30/18.
//  Copyright © 2018 Peter Olsen. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    @IBOutlet weak var plan: WKInterfaceLabel!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        let df = DateFormatter()
        df.dateStyle = .short
        df.timeZone = .none
        guard let epic = df.date(from: "10/1/2018") else {
            plan.setText("Bad Date")
            return
        }
        let today = Date()
        let seconds = today.timeIntervalSince(epic)
        guard seconds > 0 else {
            plan.setText("Wait")
            return
        }
        let day = Int(seconds / 60 / 60 / 24) + 1
        if day % 2 == 1 {
            var reps = (day + 1) * 2
            reps = (reps < 128) ? reps : 128
            plan.setText("\(reps) reps")
        } else {
            var flights = day
            flights = (flights < 64) ? flights : 64
            plan.setText("\(flights) flights")
        }
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
