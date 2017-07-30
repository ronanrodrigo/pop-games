import Foundation
import CoreData

extension GameEntityCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GameEntityCoreData> {
        return NSFetchRequest<GameEntityCoreData>(entityName: "GameEntityCoreData")
    }

    @NSManaged public var cover: NSData?
    @NSManaged public var coverUrl: String?
    @NSManaged public var id: Int32
    @NSManaged public var name: String?
    @NSManaged public var popularity: Int32
    @NSManaged public var viewers: Int32

}
