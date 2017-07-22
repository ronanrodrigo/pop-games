import Foundation
import CoreData

extension GameEntityCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GameEntityCoreData> {
        return NSFetchRequest<GameEntityCoreData>(entityName: String(describing: GameEntityCoreData.self))
    }

    @NSManaged public var name: String?
    @NSManaged public var popularity: Int32
    @NSManaged public var viewers: Int32
    @NSManaged public var id: Int32

}
