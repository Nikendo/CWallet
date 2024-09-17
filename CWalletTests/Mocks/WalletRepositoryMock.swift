//
//  WalletRepositoryMock.swift
//  CWallet
//
//  Created by Shmatov Nikita on 17.09.2024.
//

import CWallet


final class WalletRepositoryMock: WalletRepository {
    var error: Error?
    var wallet: CWallet.Wallet?
    
    func saveWallet(wallet: CWallet.Wallet) throws {
        if let error { throw error }
        
        self.wallet = wallet
    }
    
    func getWallet(blockchain: CWallet.Blockchain) throws -> CWallet.Wallet {
        if let error { throw error }
        
        guard let wallet else { throw CWallet.WalletError.notFound }
        return wallet
    }
}
