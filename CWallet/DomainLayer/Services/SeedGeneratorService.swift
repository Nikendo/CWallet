//
//  SeedGeneratorService.swift
//  CWallet
//
//  Created by Shmatov Nikita on 17.09.2024.
//

public protocol SeedGeneratorService: AnyObject {
    func generateSeed() throws -> Seed
}
