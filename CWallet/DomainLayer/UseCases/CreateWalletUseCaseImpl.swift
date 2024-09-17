//
//  CreateWalletUseCaseImpl.swift
//  CWallet
//
//  Created by Shmatov Nikita on 17.09.2024.
//


import Foundation


public final class CreateWalletUseCaseImpl: CreateWalletUseCase {
    private let walletRepository: WalletRepository
    private let blockchainService: BlockchainService
    private let seedGeneratorService: SeedGeneratorService
    
    public init(walletRepository: WalletRepository, blockchainService: BlockchainService, seedGeneratorService: SeedGeneratorService) {
        self.walletRepository = walletRepository
        self.blockchainService = blockchainService
        self.seedGeneratorService = seedGeneratorService
    }
    
    public func generateSeed() throws -> Seed {
        try seedGeneratorService.generateSeed()
    }
    
    public func createWallet(seed: Seed, name: String) throws {
        let privateKey = try blockchainService.createPrivateKey(seed: seed)
        let address = try blockchainService.createAddress(privateKey: privateKey)
        let wallet = Wallet(id: UUID(), blockchain: blockchainService.blockchainType, seed: seed, privateKey: privateKey, address: address, name: name)
        try walletRepository.saveWallet(wallet: wallet)
    }
}
