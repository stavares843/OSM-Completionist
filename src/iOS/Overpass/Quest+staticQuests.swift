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
        let answers = [Answer(title: "Yes", key: "wheelchair", value: "yes"),
                       Answer(title: "No", key: "wheelchair", value: "no")]
        let solution = Quest.Solution.multipleChoice(answers)
        
        return Quest(identifier: identifier,
                     question: question,
                     overpassWizardQuery: query,
                     solution: solution)
    }
    
    static func makeParkingFeeQuest() -> Quest {
        let identifier = "parking_fee"
        let question = "Does it cost a fee to park here? "
        let query = "(type:node or type:way) and amenity=parking and fee!=* and access~\"yes|customers|public\""
        let answers = [Answer(title: "Yes", key: "fee", value: "yes"),
                       Answer(title: "No", key: "fee", value: "no")]
        let solution = Quest.Solution.multipleChoice(answers)
        
        return Quest(identifier: identifier,
                     question: question,
                     overpassWizardQuery: query,
                     solution: solution)
    }
    
    static func makeBenchBackrestQuest() -> Quest {
        let identifier = "bench_backrest"
        let question = "Does this bench have a backrest?"
        let query = "(type:node) and amenity=bench and backrest!=*"
        let answers = [Answer(title: "Yes", key: "backrest", value: "yes"),
                       Answer(title: "No", key: "backrest", value: "no")]
        let solution = Quest.Solution.multipleChoice(answers)
        
        return Quest(identifier: identifier,
                     question: question,
                     overpassWizardQuery: query,
                     solution: solution)
    }
    
    static func makePlaygroundAccessQuest() -> Quest {
        let identifier = "playground_access"
        let question = "Is this playground generally accessible?"
        let query = "leisure=playground and (access!=* or access=unknown)"
        let answers = [Answer(title: "Yes", key: "access", value: "yes"),
                       Answer(title: "No", key: "access", value: "private")]
        let solution = Quest.Solution.multipleChoice(answers)
        
        return Quest(identifier: identifier,
                     question: question,
                     overpassWizardQuery: query,
                     solution: solution)
    }
    
    static func makeToiletQuest() -> Quest {
        let identifier = "toilet"
        let question = "Does this place have a toilet?"
        let query = "(type:node or type:way) and ( (shop ~= \"mall|department_store\" and name = *) or (highway~\"services|rest_area\") ) and toilets != *"
        let answers = [Answer(title: "Yes", key: "toilets", value: "yes"),
                       Answer(title: "No", key: "toilets", value: "no")]
        let solution = Quest.Solution.multipleChoice(answers)
        
        return Quest(identifier: identifier,
                     question: question,
                     overpassWizardQuery: query,
                     solution: solution)
    }
    
    static func makeBicycleParkingCoveredQuest() -> Quest {
        let identifier = "bicycle_parking_covered"
        let question = "Is this bicycle parking covered (protected from rain)?"
        let query = "(type:node or type:way) and amenity=bicycle_parking and access!~\"private|no\" and covered!=* and bicycle_parking !~ \"shed|lockers|building\""
        let answers = [Answer(title: "Yes", key: "covered", value: "yes"),
                       Answer(title: "No", key: "covered", value: "no")]
        let solution = Quest.Solution.multipleChoice(answers)
        
        return Quest(identifier: identifier,
                     question: question,
                     overpassWizardQuery: query,
                     solution: solution)
    }
    
    static func makeBicycleParkingTypeQuest() -> Quest {
        let identifier = "bicycle_parking_type"
        let question = "What is the type of this bicycle parking?"
        let query = "(type:node or type:way) and amenity=bicycle_parking and bicycle_parking!=* and access!=private"
        let answers = [Answer(title: "Building", key: "bicycle_parking", value: "building"),
                       Answer(title: "Locker", key: "bicycle_parking", value: "lockers"),
                       Answer(title: "Shed", key: "bicycle_parking", value: "shed"),
                       Answer(title: "Stand", key: "bicycle_parking", value: "stands"),
                       Answer(title: "Wheelbender", key: "bicycle_parking", value: "wall_loops")]
        let solution = Quest.Solution.multipleChoice(answers)
        
        return Quest(identifier: identifier,
                     question: question,
                     overpassWizardQuery: query,
                     solution: solution)
    }
    
    static func makeBicycleParkingQuest() -> Quest {
        let identifier = "bicycle_parking"
        let question = "How many bikes can be parked here?"
        let query = "(type:node or type:way) and amenity=bicycle_parking and capacity!=*  and (access!~\"private|no\")"
        let solution = Quest.Solution.numeric("capacity")
        
        return Quest(identifier: identifier,
                     question: question,
                     overpassWizardQuery: query,
                     solution: solution)
    }
    
    static func makeMotorcycleParkingQuest() -> Quest {
        let identifier = "motorcycle_parking"
        let question = "How many motorcycles can be parked here?"
        let query = "(type:node or type:way) and amenity=motorcycle_parking and capacity!=*  and (access!~\"private|no\")"
        let solution = Quest.Solution.numeric("capacity")
        
        return Quest(identifier: identifier,
                     question: question,
                     overpassWizardQuery: query,
                     solution: solution)
    }
    
}
