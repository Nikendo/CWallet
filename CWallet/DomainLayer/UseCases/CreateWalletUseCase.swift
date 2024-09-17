//
//  CreateWalletUseCase.swift
//  CWallet
//
//  Created by Shmatov Nikita on 17.09.2024.
//

public protocol CreateWalletUseCase: AnyObject {
    func generateSeed() throws -> Seed
    func createWallet(seed: Seed, name: String) throws
}
