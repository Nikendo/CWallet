//
//  BlockchainService.swift
//  CWallet
//
//  Created by Shmatov Nikita on 17.09.2024.
//

public protocol BlockchainService: AnyObject {
    var blockchainType: Blockchain { get }
    
    func createPrivateKey(seed: Seed) throws -> PrivateKey
    func createAddress(privateKey: PrivateKey) throws -> String
}
