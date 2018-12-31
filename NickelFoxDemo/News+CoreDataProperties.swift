//
//  News+CoreDataProperties.swift
//  
//
//  Created by Ruchin Somal on 31/12/18.
//
//

import Foundation
import CoreData


extension News {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<News> {
        return NSFetchRequest<News>(entityName: "News")
    }

    @NSManaged public var title: String?
    @NSManaged public var author: String?
    @NSManaged public var image: String?
    @NSManaged public var url: String?

}
