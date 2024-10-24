//
//  Entity+CoreDataProperties.swift
//  ToDo
//
//  Created by Zhongxin qiu on 2024/10/24.
//
//

import Foundation
import CoreData


extension Entity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entity> {
        return NSFetchRequest<Entity>(entityName: "Entity")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var isCompleted: Bool
    @NSManaged public var todoItem: String?

}

extension Entity : Identifiable {

}

@objc(Entity)
public class Entity: NSManagedObject {
    // 可以在这里添加自定义方法或属性
}
