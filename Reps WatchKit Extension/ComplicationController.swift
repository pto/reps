//
//  ComplicationController.swift
//  Reps WatchKit Extension
//
//  Created by Peter Olsen on 10/1/18.
//  Copyright © 2018 Peter Olsen. All rights reserved.
//

import WatchKit

var myComplication: CLKComplication?

class ComplicationController: NSObject, CLKComplicationDataSource {
    
    // MARK: - Timeline Configuration
    
    func getSupportedTimeTravelDirections(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimeTravelDirections) -> Void) {
        handler([])
    }
    
//    func getTimelineStartDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
//        handler(nil)
//    }
//
//    func getTimelineEndDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
//        handler(nil)
//    }
    
    func getPrivacyBehavior(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationPrivacyBehavior) -> Void) {
        handler(.showOnLockScreen)
    }
    
    // MARK: - Timeline Population
    
    func getCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimelineEntry?) -> Void) {
        // Call the handler with the current timeline entry
        myComplication = complication
        let template = getComplicationTemplate(for: complication)
        if let t = template {
            let entry = CLKComplicationTimelineEntry(date: Date(), complicationTemplate: t)
            handler(entry)
        }
    }
    
//    func getTimelineEntries(for complication: CLKComplication, before date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
//        // Call the handler with the timeline entries prior to the given date
//        handler(nil)
//    }
    
//    func getTimelineEntries(for complication: CLKComplication, after date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
//        // Call the handler with the timeline entries after to the given date
//        handler(nil)
//    }
    
    // Update every 6 hours
    func getNextRequestedUpdateDate(handler: @escaping (Date?) -> Void) {
        handler(Date().addingTimeInterval(TimeInterval(6*60*60)))
    }
    
    // MARK: - Placeholder Templates
    
    func getLocalizableSampleTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
        // This method will be called once per supported complication, and the results will be cached
        let template = getComplicationTemplate(for: complication)
        if let t = template {
            handler(t)
        }
    }
    
    func getComplicationTemplate(for complication: CLKComplication) -> CLKComplicationTemplate? {
        switch complication.family {
        case .circularSmall:
            let template = CLKComplicationTemplateCircularSmallSimpleText()
            let df = DateFormatter()
            df.dateFormat = "d"
            let d = df.string(from: Date())
            template.textProvider = CLKSimpleTextProvider(text: d, shortText: d)
            return template
        default:
            return nil
        }
    }
}
