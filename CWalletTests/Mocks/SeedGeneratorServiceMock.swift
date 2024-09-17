//
//  SeedGeneratorServiceMock.swift
//  CWalletTests
//
//  Created by Shmatov Nikita on 18.09.2024.
//

import CWallet


final class SeedGeneratorServiceMock: SeedGeneratorService {
    var error: Error?
    var seed: Seed!
    
    func generateSeed() throws -> CWallet.Seed {
        if let error { throw error }
        return seed
    }
}
