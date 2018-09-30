//
//  ViewController.swift
//  Reps
//
//  Created by Peter Olsen on 9/30/18.
//  Copyright © 2018 Peter Olsen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var day: UILabel!
    @IBOutlet weak var plan: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        date.text = " "
        day.text = " "
        plan.text = " "
        let df = DateFormatter()
        df.dateStyle = .short
        df.timeZone = .none
        guard let epic = df.date(from: "10/1/2018") else {
            date.text = "Bad date"
            return
        }
        let today = Date()
        date.text = df.string(from: today)
        let seconds = today.timeIntervalSince(epic)
        guard seconds > 0 else {
            plan.text = "Wait"
            return
        }
        let dayNum = Int(seconds / 60 / 60 / 24) + 1
        day.text = String(dayNum)
        if dayNum % 2 == 1 {
            var reps = (dayNum + 1) * 2
            reps = (reps < 128) ? reps : 128
            plan.text = "\(reps) reps"
        } else {
            var flights = dayNum
            flights = (flights < 64) ? flights : 64
            plan.text = "\(flights) flights"
        }
    }


}

