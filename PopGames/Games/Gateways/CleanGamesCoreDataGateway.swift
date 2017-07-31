import CoreData

struct CleanGamesCoreDataGateway: CleanGamesGateway {

    private let privateManagedObjectContext: NSManagedObjectContext

    init(managedObjectContext: NSManagedObjectContext) {
        self.privateManagedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        privateManagedObjectContext.parent = managedObjectContext
    }

    func clean() -> Future<Void> {
        return Future { completion in
            let fetchGames = NSFetchRequest<NSFetchRequestResult>(
                entityName: String(describing: GameEntityCoreData.self))
            let delete = NSBatchDeleteRequest(fetchRequest: fetchGames)

            do {
                try privateManagedObjectContext.execute(delete)
                completion(Result.success(()))
            } catch {
                completion(Result.fail(error))
            }
        }
    }
}
