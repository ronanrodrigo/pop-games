import CoreData

struct CleanGamesCoreDataGateway: CleanGamesGateway {

    private let managedObjectContext: NSManagedObjectContext

    init(managedObjectContext: NSManagedObjectContext) {
        self.managedObjectContext = managedObjectContext
    }

    func clean() -> Future<Void> {
        return Future { completion in
            let fetchGames = NSFetchRequest<NSFetchRequestResult>(
                entityName: String(describing: GameEntityCoreData.self))
            let delete = NSBatchDeleteRequest(fetchRequest: fetchGames)

            do {
                try managedObjectContext.execute(delete)
                completion(Result.success(()))
            } catch {
                completion(Result.fail(error))
            }
        }
    }
}
