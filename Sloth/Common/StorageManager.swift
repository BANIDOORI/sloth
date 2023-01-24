//
//  StorageManager.swift
//  Sloth
//
//  Created by user on 2023/01/24.
//

import Foundation
import Security

final class StorageManager<T: Codable> {

    // MARK: Keychain
    private var account: String
    private let service = Bundle.main.bundleIdentifier

    init(type account: StorageType) {
        self.account = account.rawValue
    }

    private lazy var query: [CFString: Any]? = {
        guard let service = service else { return nil }
        return [kSecClass: kSecClassGenericPassword,
                kSecAttrService: service,
                kSecAttrAccount: account]
    }()

    func store(_ datas: T) -> Bool {
        guard let data = try? JSONEncoder().encode(datas),
              let service = service else { return false }

        let query: [CFString: Any] = [kSecClass: kSecClassGenericPassword,
                                      kSecAttrService: service,
                                      kSecAttrAccount: account,
                                      kSecAttrGeneric: data]
        _ = delete()
        return SecItemAdd(query as CFDictionary, nil) == errSecSuccess
    }

    func load() -> T? {
        guard let service = service else { return nil }
        let query: [CFString: Any] = [kSecClass: kSecClassGenericPassword,
                                      kSecAttrService: service,
                                      kSecAttrAccount: account,
                                      kSecMatchLimit: kSecMatchLimitOne,
                                      kSecReturnAttributes: true,
                                      kSecReturnData: true]

        var item: CFTypeRef?
        if SecItemCopyMatching(query as CFDictionary, &item) != errSecSuccess { return nil }

        guard let existingItem = item as? [String: Any],
              let data = existingItem[kSecAttrGeneric as String] as? Data,
              let datas = try? JSONDecoder().decode(T.self, from: data) else { return nil }

        return datas
    }

    func delete() -> Bool {
        guard let query = query else { return false }
        return SecItemDelete(query as CFDictionary) == errSecSuccess
    }

    enum StorageType: String {
        case token
    }
}
