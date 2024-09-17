//
//  WalletError.swift
//  CWallet
//
//  Created by Shmatov Nikita on 17.09.2024.
//


public enum WalletError: Error {
    case restoreFailed
    case savingFailed
    case extractingFailed
    case notFound
}
