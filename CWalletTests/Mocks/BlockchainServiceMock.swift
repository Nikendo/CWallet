//
//  BlockchainServiceMock.swift
//  CWalletTests
//
//  Created by Shmatov Nikita on 17.09.2024.
//

import CWallet


final class BlockchainServiceMock: BlockchainService {
    var error: Error?
    var privateKey: PrivateKey!
    var address: String!
    var blockchainType: CWallet.Blockchain = .bitcoin
    
    func createPrivateKey(seed: CWallet.Seed) throws -> CWallet.PrivateKey {
        if let error { throw error }
        return privateKey
    }
    
    func createAddress(privateKey: CWallet.PrivateKey) throws -> String {
        if let error { throw error }
        return address
    }
}
