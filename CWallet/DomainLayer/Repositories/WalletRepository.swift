//
//  WalletRepository.swift
//  CWallet
//
//  Created by Shmatov Nikita on 17.09.2024.
//

import Foundation

public protocol WalletRepository: AnyObject {
    func saveWallet(wallet: Wallet) throws
    func getWallet(blockchain: Blockchain) throws -> Wallet
}
