import Foundation
import SwiftData

final class LocalStorageUtil {
    private let modelContext: ModelContext
    private let defaults: UserDefaults

    init(modelContext: ModelContext, defaults: UserDefaults = .standard) {
        self.modelContext = modelContext
        self.defaults = defaults
    }

    // MARK: - SwiftData Generic CRUD

    func insert<T: PersistentModel>(_ model: T) {
        modelContext.insert(model)
        save()
    }

    func fetch<T: PersistentModel>(
        _ type: T.Type,
        descriptor: FetchDescriptor<T>
    ) -> [T] {
        (try? modelContext.fetch(descriptor)) ?? []
    }

    func fetchAll<T: PersistentModel>(
        _ type: T.Type,
        sortBy sortDescriptors: [SortDescriptor<T>] = []
    ) -> [T] {
        let descriptor = FetchDescriptor<T>(sortBy: sortDescriptors)
        return (try? modelContext.fetch(descriptor)) ?? []
    }

    func fetchCount<T: PersistentModel>(_ type: T.Type) -> Int {
        let descriptor = FetchDescriptor<T>()
        return (try? modelContext.fetchCount(descriptor)) ?? 0
    }

    func delete<T: PersistentModel>(_ model: T) {
        modelContext.delete(model)
        save()
    }

    func deleteAll<T: PersistentModel>(_ type: T.Type) {
        do {
            try modelContext.delete(model: type)
        } catch {}
        save()
    }

    func save() {
        try? modelContext.save()
    }

    // MARK: - UserDefaults Key-Value Storage

    func set(_ value: Any?, forKey key: StorageKeys) {
        defaults.set(value, forKey: key.rawValue)
    }

    func getString(forKey key: StorageKeys) -> String? {
        defaults.string(forKey: key.rawValue)
    }

    func getInt(forKey key: StorageKeys) -> Int {
        defaults.integer(forKey: key.rawValue)
    }

    func getBool(forKey key: StorageKeys) -> Bool {
        defaults.bool(forKey: key.rawValue)
    }

    func getDouble(forKey key: StorageKeys) -> Double {
        defaults.double(forKey: key.rawValue)
    }

    func getDate(forKey key: StorageKeys) -> Date? {
        defaults.object(forKey: key.rawValue) as? Date
    }

    func remove(forKey key: StorageKeys) {
        defaults.removeObject(forKey: key.rawValue)
    }
}
