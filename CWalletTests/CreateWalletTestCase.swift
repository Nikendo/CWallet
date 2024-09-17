//
//  CreateWalletTestCase.swift
//  CWalletTests
//
//  Created by Shmatov Nikita on 17.09.2024.
//

import XCTest
import CWallet

final class CreateWalletTestCase: XCTestCase {

    private var createWalletUseCase: CreateWalletUseCaseImpl!
    private var walletRepository: WalletRepositoryMock!
    private var blockchainService: BlockchainServiceMock!
    private var seedGeneratorService: SeedGeneratorServiceMock!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        walletRepository = WalletRepositoryMock()
        blockchainService = BlockchainServiceMock()
        seedGeneratorService = SeedGeneratorServiceMock()
        createWalletUseCase = CreateWalletUseCaseImpl(walletRepository: walletRepository, blockchainService: blockchainService, seedGeneratorService: seedGeneratorService)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        walletRepository = nil
        blockchainService = nil
        seedGeneratorService = nil
        createWalletUseCase = nil
    }
    
    func testCreateNewWalletSuccess() throws {
        // Given
        let id = UUID()
        let blockchain = Blockchain.bitcoin
        let seed = Seed(phrase: "seed phrase")
        let privateKey = PrivateKey(key: "private_key")
        let address = "wallet_address"
        let walletName = "New wallet"
        let wallet = Wallet(id: id, blockchain: blockchain, seed: seed, privateKey: privateKey, address: address, name: walletName)
        
        walletRepository.wallet = wallet
        blockchainService.blockchainType = blockchain
        blockchainService.privateKey = privateKey
        blockchainService.address = address
        seedGeneratorService.seed = seed
        
        // When
        let generatedSeed = try createWalletUseCase.generateSeed()
        try createWalletUseCase.createWallet(seed: generatedSeed, name: walletName)
        let newWallet = try walletRepository.getWallet(blockchain: blockchain)
        
        // Then
        XCTAssertEqual(wallet.blockchain, newWallet.blockchain)
        XCTAssertEqual(wallet.seed.phrase, newWallet.seed.phrase)
        XCTAssertEqual(wallet.privateKey.key, newWallet.privateKey.key)
        XCTAssertEqual(wallet.address, newWallet.address)
        XCTAssertEqual(wallet.name, newWallet.name)
    }
    
    func testCreateNewWalletFailed() throws {
        // Given
        let id = UUID()
        let blockchain = Blockchain.bitcoin
        let seed = Seed(phrase: "seed phrase")
        let privateKey = PrivateKey(key: "private_key")
        let address = "wallet_address"
        let walletName = "New wallet"
        let wallet = Wallet(id: id, blockchain: blockchain, seed: seed, privateKey: privateKey, address: address, name: walletName)
        
        walletRepository.wallet = wallet
        walletRepository.error = WalletError.savingFailed
        blockchainService.blockchainType = blockchain
        blockchainService.privateKey = privateKey
        blockchainService.address = address
        seedGeneratorService.seed = seed
        
        // When
        let generatedSeed = try createWalletUseCase.generateSeed()
        
        // Then
        XCTAssertThrowsError(try createWalletUseCase.createWallet(seed: generatedSeed, name: walletName))
    }
    
    func testImportWalletFromSeedSuccess() throws {
        // Given
        let id = UUID()
        let blockchain = Blockchain.bitcoin
        let seed = Seed(phrase: "seed phrase")
        let privateKey = PrivateKey(key: "private_key")
        let address = "wallet_address"
        let walletName = "New wallet"
        let wallet = Wallet(id: id, blockchain: blockchain, seed: seed, privateKey: privateKey, address: address, name: walletName)
        
        walletRepository.wallet = wallet
        blockchainService.blockchainType = blockchain
        blockchainService.privateKey = privateKey
        blockchainService.address = address
        
        // When
        try createWalletUseCase.createWallet(seed: seed, name: walletName)
        let newWallet = try walletRepository.getWallet(blockchain: blockchain)
        
        // Then
        XCTAssertEqual(wallet.blockchain, newWallet.blockchain)
        XCTAssertEqual(wallet.seed.phrase, newWallet.seed.phrase)
        XCTAssertEqual(wallet.privateKey.key, newWallet.privateKey.key)
        XCTAssertEqual(wallet.address, newWallet.address)
        XCTAssertEqual(wallet.name, newWallet.name)
    }
    
    func testImportWalletFromSeedFailed() throws {
        // Given
        let blockchain = Blockchain.bitcoin
        let seed = Seed(phrase: "seed phrase")
        let walletName = "New wallet"
        
        blockchainService.blockchainType = blockchain
        blockchainService.error = SeedError.invalidFormat
        seedGeneratorService.seed = seed
        
        // When
        // Then
        XCTAssertThrowsError(try createWalletUseCase.createWallet(seed: seed, name: walletName))
    }
}
