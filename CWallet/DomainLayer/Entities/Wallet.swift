//
//  Wallet.swift
//  CWallet
//
//  Created by Shmatov Nikita on 17.09.2024.
//

import Foundation

public struct Wallet {
    public let id: UUID
    public let blockchain: Blockchain
    public let seed: Seed
    public let privateKey: PrivateKey
    public let address: String
    public let name: String
    
    public init(id: UUID, blockchain: Blockchain, seed: Seed, privateKey: PrivateKey, address: String, name: String) {
        self.id = id
        self.blockchain = blockchain
        self.seed = seed
        self.privateKey = privateKey
        self.address = address
        self.name = name
    }
}
