//
//  Quest+staticQuests.swift
//  Go Map!!
//
//  Created by Wolfgang Timme on 1/5/20.
//  Copyright © 2020 Bryce. All rights reserved.
//

/// This extension contains `Quest`s that are compiled into the app.
extension Quest {
    
    static func makeAccessibleToiletsQuest() -> Quest {
        let identifier = "accessible_toilets"
        let question = "Are these toilets wheelchair accessible?"
        let query = "(type:node or type:way) and amenity=toilets and access !~ \"private|customers\" and wheelchair!=*"
        
        return Quest(identifier: identifier,
                     question: question,
                     overpassWizardQuery: query)
    }
    
}
